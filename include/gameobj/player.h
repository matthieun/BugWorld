#ifndef PLAYER_H
#define PLAYER_H

#include "gameobj/sprite.h"

/*
 * The player code controlling animations and scoring logic.
 */

#define M_SET_PLAYER_POS(player, row, col) \
do {                                       \
player_set_row(player, row);               \
player_set_col(player, col);               \
} while(0)

struct player;

struct player * create_player(int row, int col);
void destroy_player(struct player * p);

void tick_player(struct player * p);
void render_player(struct player * p);

int player_row(struct player * p);
int player_col(struct player * p);

void player_set_row(struct player * p, int row);
void player_set_col(struct player * p, int col);

#endif
