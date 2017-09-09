
#ifndef STATE_CODES_H
#define STATE_CODES_H

/*
 * Contains codes for the game states as well as definitions
 * for functions that states use to hook into the manager.
 */

// Manually set this to the number of defined states
#define M_NUM_STATES (4)

/* Define all states below */
#define M_STATE_MENU (0)
#define M_STATE_PLAY (1)
#define M_STATE_PAUSE (2)
#define M_STATE_SCORES (3)

/*
 * Functions that allow game states to
 * request services from the state manager.
 * These are implemented in state_manager.c
 */
void init_state(int code);
void resume_state(int code);
void force_exit(void);

#endif
