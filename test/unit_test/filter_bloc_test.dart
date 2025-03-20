import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:diamond_kgk_app/bloc/filter/filter_bloc.dart';
import 'package:diamond_kgk_app/bloc/filter/filter_state.dart';
import 'package:diamond_kgk_app/bloc/filter/filter_event.dart';
import 'package:diamond_kgk_app/data/models/diamond_model.dart';

void main() {
  // Create some dummy diamonds for testing.
  final dummyDiamonds = [
    DiamondModel(
      lotId: '001',
      carat: 1.5,
      finalAmount: 1500.0,
      discount: 10.0,
      size: 1.0,
      clarity: 'VS1',
      color: 'D',
      cut: 'Round',
      polish: 'Excellent',
      symmetry: 'Excellent',
      fluorescence: 'None',
      perCaratRate: 1000.0,
      lab: 'GIA',
      shape: 'Round',
      keyToSymbol: 'D',
      labComment: 'Test comment',
    ),
    DiamondModel(
      lotId: '002',
      carat: 2.0,
      finalAmount: 3000.0,
      discount: 5.0,
      size: 1.0,
      clarity: 'VVS1',
      color: 'E',
      cut: 'Princess',
      polish: 'Very Good',
      symmetry: 'Very Good',
      fluorescence: 'Faint',
      perCaratRate: 1500.0,
      lab: 'IGI',
      shape: 'Princess',
      keyToSymbol: 'E',
      labComment: 'Test comment 2',
    ),
  ];

  group('FilterBloc', () {
    late FilterBloc filterBloc;

    setUp(() {
      // Create a new FilterBloc instance before each test.
      filterBloc = FilterBloc(allDiamonds: dummyDiamonds);
    });

    tearDown(() {
      filterBloc.close();
    });

    test('initial state is FilterState.initial()', () {
      expect(filterBloc.state, FilterState.initial());
    });

    blocTest<FilterBloc, FilterState>(
      'emits updated state with new fromCarat when UpdateCaratFromEvent is added',
      build: () => filterBloc,
      act: (bloc) => bloc.add(UpdateCaratFromEvent(1.5)),
      expect:
          () => [
            filterBloc.state.copyWith(
              filter: filterBloc.state.filter.copyWith(fromCarat: 1.5),
            ),
          ],
    );

    blocTest<FilterBloc, FilterState>(
      'emits updated state with new toCarat when UpdateCaratToEvent is added',
      build: () => filterBloc,
      act: (bloc) => bloc.add(UpdateCaratToEvent(2.0)),
      expect:
          () => [
            filterBloc.state.copyWith(
              filter: filterBloc.state.filter.copyWith(toCarat: 2.0),
            ),
          ],
    );

    blocTest<FilterBloc, FilterState>(
      'emits updated state with new lab when UpdateLabEvent is added',
      build: () => filterBloc,
      act: (bloc) => bloc.add(UpdateLabEvent('GIA')),
      expect:
          () => [
            filterBloc.state.copyWith(
              filter: filterBloc.state.filter.copyWith(lab: 'GIA'),
            ),
          ],
    );

    blocTest<FilterBloc, FilterState>(
      'emits updated state with new shape when UpdateShapeEvent is added',
      build: () => filterBloc,
      act: (bloc) => bloc.add(UpdateShapeEvent('Round')),
      expect:
          () => [
            filterBloc.state.copyWith(
              filter: filterBloc.state.filter.copyWith(shape: 'Round'),
            ),
          ],
    );

    blocTest<FilterBloc, FilterState>(
      'emits updated state with new color when UpdateColorEvent is added',
      build: () => filterBloc,
      act: (bloc) => bloc.add(UpdateColorEvent('D')),
      expect:
          () => [
            filterBloc.state.copyWith(
              filter: filterBloc.state.filter.copyWith(color: 'D'),
            ),
          ],
    );

    blocTest<FilterBloc, FilterState>(
      'emits updated state with new clarity when UpdateClarityEvent is added',
      build: () => filterBloc,
      act: (bloc) => bloc.add(UpdateClarityEvent('VS1')),
      expect:
          () => [
            filterBloc.state.copyWith(
              filter: filterBloc.state.filter.copyWith(clarity: 'VS1'),
            ),
          ],
    );

    blocTest<FilterBloc, FilterState>(
      'emits filtered diamonds list when SearchDiamondsEvent is added',
      build: () => filterBloc,
      seed:
          () => filterBloc.state.copyWith(
            filter: filterBloc.state.filter.copyWith(
              fromCarat: 1.0,
              toCarat: 1.8,
              lab: 'GIA',
              shape: 'Round',
              color: '',
              clarity: '',
            ),
          ),
      act: (bloc) => bloc.add(SearchDiamondsEvent()),
      expect:
          () => [
            // The search should return only the first diamond from dummyDiamonds.
            filterBloc.state.copyWith(filteredDiamonds: [dummyDiamonds.first]),
          ],
    );
  });
}
