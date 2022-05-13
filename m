Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D801C433EF
	for <rcu@archiver.kernel.org>; Fri, 13 May 2022 15:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiEMPn7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 13 May 2022 11:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234876AbiEMPn6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 13 May 2022 11:43:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D714930F66
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 08:43:55 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id bx33so10720631ljb.12
        for <rcu@vger.kernel.org>; Fri, 13 May 2022 08:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xkvqen8KNDDi6FzW8P6U1ArLg0L7OXWg7PduxqwIXcg=;
        b=dDsu277zlY9AuBwTUcyVgfH1u+AwSHT0CxTbaDP+fU+AF3kQE80iPWTN+Rc1eSpX5v
         01pR1I54ELaAd5mdbvFKx3FOWwL2Oru0UZQI8H3D/sev2CqkygQotaP0DExNYkA1wjHQ
         OT2pG3xw4b/kRCrk3fG3zoCHtK29KEaB72/F6HfkmXfo9fWGNSSP8+8rgtkL3CPEJdvP
         QdVSMrza1BIy103GyAmD+WLHIgiA/3VPuzhQXM1QErYB428dKI4uGU5p5PSuqBthcBe7
         OF1wr1qNF+Zanx/cPTF9rtOjlwOBvSnGRnv2SEAntpJxJWHlYwyu7iiLZ3uLpPpYfgxe
         L/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xkvqen8KNDDi6FzW8P6U1ArLg0L7OXWg7PduxqwIXcg=;
        b=2cSLMfHyS+PCtZMD6e2R4DSERDoUhztAVBwrQ8L7VcFUioS4FH8iTOltyTBwpFDoJE
         QRqH9TJuS33YXYhGaYI45R2R8R1Cr1m8WBDylT49khZpUiTCp3Wn2aEkq642EGn2vGY3
         7qsEmulOGcsiP8hOhVOhLCfEJu3PvIeygrR6vUO1keF5ZTlD+hd2IF251fIc8euDdXbh
         HGlw01LNFSqknaUsOviWTY3xeP3UvdUFAhWjuNP1NmVqfkGOcyaxN51WIJiyqnKcSeis
         i3DciifE/VT3bDY9MQqT5JKqD/yRdU81dty2AbZ1/ZN3ZbuTEjoo01zsrloQ6Gw3aoR/
         Ol/w==
X-Gm-Message-State: AOAM530z443nbs9mJAN6bQ0ilnrsega46FhtLDAcQe/uN9x0GdOguqOd
        /1kWKIjXEd95nlwGnjsbtWo=
X-Google-Smtp-Source: ABdhPJyW6bhHtmAtTzL6PH441bi8SOu/T8mntvKMCgl6YnKYcC811j8yb2YvOHoSV3tDIyzU/JZARQ==
X-Received: by 2002:a2e:9e02:0:b0:249:7d50:bd8c with SMTP id e2-20020a2e9e02000000b002497d50bd8cmr3376385ljk.327.1652456633943;
        Fri, 13 May 2022 08:43:53 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id b10-20020ac25e8a000000b0047255d21113sm419445lfq.66.2022.05.13.08.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:43:53 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Fri, 13 May 2022 17:43:51 +0200
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 00/14] Implement call_rcu_lazy() and miscellaneous fixes
Message-ID: <Yn58t2UWtj9YfJPR@pc638.lan>
References: <20220512030442.2530552-1-joel@joelfernandes.org>
 <CAEXW_YQ+9GK+b5_k6ZtDgSPb9S0RQ8FVcJbHoy-T2GGRpq9Zag@mail.gmail.com>
 <CA+KHdyVTwtC274v=Mmbwe3jaRPsme1mENWiOR+m2uDV=3SBTBQ@mail.gmail.com>
 <CA+KHdyVGCC2-S8waURWL_cwjdv8EyeUwnLFNVYHn+h7TrteP6g@mail.gmail.com>
 <Yn0TuehXj6VoWG0A@google.com>
 <Yn0bwhkdfPvbjIwK@pc638.lan>
 <CAEXW_YQNPDJ8aaxKzG2NN9gVR_QPbarJthiXYRd9Erw7p5V=FA@mail.gmail.com>
 <Yn02uhvov7CDoKX7@pc638.lan>
 <Yn5e7w8NWzThUARb@pc638.lan>
 <CAEXW_YQSLSAOAYDhztreYu=t2v8HPCdjRwJ=5Bx6N3LT8frtkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+p1/KCQbdo0Dd/Ot"
Content-Disposition: inline
In-Reply-To: <CAEXW_YQSLSAOAYDhztreYu=t2v8HPCdjRwJ=5Bx6N3LT8frtkQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org


--+p1/KCQbdo0Dd/Ot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> On Fri, May 13, 2022 at 9:36 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > > > On Thu, May 12, 2022 at 10:37 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > > > >
> > > > > > On Thu, May 12, 2022 at 03:56:37PM +0200, Uladzislau Rezki wrote:
> > > > > > > Never mind. I port it into 5.10
> > > > > >
> > > > > > Oh, this is on mainline. Sorry about that. If you want I have a tree here for
> > > > > > 5.10 , although that does not have the kfree changes, everything else is
> > > > > > ditto.
> > > > > > https://github.com/joelagnel/linux-kernel/tree/rcu-nocb-4
> > > > > >
> > > > > No problem. kfree_rcu two patches are not so important in this series.
> > > > > So i have backported them into my 5.10 kernel because the latest kernel
> > > > > is not so easy to up and run on my device :)
> > > >
> > > > Actually I was going to write here, apparently some tests are showing
> > > > kfree_rcu()->call_rcu_lazy() causing possible regression. So it is
> > > > good to drop those for your initial testing!
> > > >
> > > Yep, i dropped both. The one that make use of call_rcu_lazy() seems not
> > > so important for kfree_rcu() because we do batch requests there anyway.
> > > One thing that i would like to improve in kfree_rcu() is a better utilization
> > > of page slots.
> > >
> > > I will share my results either tomorrow or on Monday. I hope that is fine.
> > >
> >
> > Here we go with some data on our Android handset that runs 5.10 kernel. The test
> > case i have checked was a "static image" use case. Condition is: screen ON with
> > disabled all connectivity.
> >
> > 1.
> > First data i took is how many wakeups cause an RCU subsystem during this test case
> > when everything is pretty idling. Duration is 360 seconds:
> >
> > <snip>
> > serezkiul@seldlx26095:~/data/call_rcu_lazy$ ./psp ./perf_360_sec_rcu_lazy_off.script | sort -nk 6 | grep rcu
> 
> Nice! Do you mind sharing this script? I was just talking to Rushikesh
> that we want something like this during testing. Appreciate it. Also,
> if we dump timer wakeup reasons/callbacks that would also be awesome.
> 
Please find in attachment. I wrote it once upon a time and make use of
to parse "perf script" output, i.e. raw data. The file name is: perf_script_parser.c
so just compile it.

How to use it:
1. run perf: './perf sched record -a -- sleep "how much in sec you want to collect data"'
2. ./perf script -i ./perf.data > foo.script
3. ./perf_script_parser ./foo.script

>
> FWIW, I wrote a BPF tool that periodically dumps callbacks and can
> share that with you on request as well. That is probably not in a
> shape for mainline though (Makefile missing and such).
> 
Yep, please share!

> > name:                         rcub/0 pid:         16 woken-up     2     interval: min 86772734  max 86772734    avg 43386367
> > name:                        rcuop/7 pid:         69 woken-up     4     interval: min  4189     max  8050       avg  5049
> > name:                        rcuop/6 pid:         62 woken-up    55     interval: min  6910     max 42592159    avg 3818752
> [..]
> 
> > There is a big improvement in lazy case. Number of wake-ups got reduced quite a lot
> > and it is really good!
> 
> Cool!
> 
> > 2.
> > Please find in attachment two power plots. The same test case. One is related to a
> > regular use of call_rcu() and second one is "lazy" usage. There is light a difference
> > in power, it is ~2mA. Event though it is rather small but it is detectable and solid
> > what is also important, thus it proofs the concept. Please note it might be more power
> > efficient for other arches and platforms. Because of different HW design that is related
> > to C-states of CPU and energy that is needed to in/out of those deep power states.
> 
> Nice! I wonder if you still have other frequent callbacks on your
> system that are getting queued during the tests. Could you dump the
> rcu_callbacks trace event and see if you have any CBs frequently
> called that the series did not address?
>
I have pretty much like this:
<snip>
    rcuop/2-33      [002] d..1  6172.420541: rcu_batch_start: rcu_preempt CBs=2048 bl=16
    rcuop/1-26      [001] d..1  6173.131965: rcu_batch_start: rcu_preempt CBs=2048 bl=16
    rcuop/0-15      [001] d..1  6173.696540: rcu_batch_start: rcu_preempt CBs=2048 bl=16
    rcuop/3-40      [003] d..1  6173.703695: rcu_batch_start: rcu_preempt CBs=2048 bl=16
    rcuop/0-15      [001] d..1  6173.711607: rcu_batch_start: rcu_preempt CBs=1667 bl=13
    rcuop/1-26      [000] d..1  6175.619722: rcu_batch_start: rcu_preempt CBs=2048 bl=16
    rcuop/2-33      [001] d..1  6176.135844: rcu_batch_start: rcu_preempt CBs=2048 bl=16
    rcuop/3-40      [002] d..1  6176.303723: rcu_batch_start: rcu_preempt CBs=2048 bl=16
    rcuop/0-15      [002] d..1  6176.519894: rcu_batch_start: rcu_preempt CBs=2048 bl=16
    rcuop/0-15      [003] d..1  6176.527895: rcu_batch_start: rcu_preempt CBs=273 bl=10
    rcuop/1-26      [003] d..1  6178.543729: rcu_batch_start: rcu_preempt CBs=2048 bl=16
    rcuop/1-26      [003] d..1  6178.551707: rcu_batch_start: rcu_preempt CBs=1317 bl=10
    rcuop/0-15      [003] d..1  6178.819698: rcu_batch_start: rcu_preempt CBs=2048 bl=16
    rcuop/0-15      [003] d..1  6178.827734: rcu_batch_start: rcu_preempt CBs=949 bl=10
    rcuop/3-40      [001] d..1  6179.203645: rcu_batch_start: rcu_preempt CBs=2048 bl=16
    rcuop/2-33      [001] d..1  6179.455747: rcu_batch_start: rcu_preempt CBs=2048 bl=16
    rcuop/2-33      [002] d..1  6179.471725: rcu_batch_start: rcu_preempt CBs=1983 bl=15
    rcuop/1-26      [003] d..1  6181.287646: rcu_batch_start: rcu_preempt CBs=2048 bl=16
    rcuop/1-26      [003] d..1  6181.295607: rcu_batch_start: rcu_preempt CBs=55 bl=10
<snip>

so almost everything is batched.

>
> Also, one more thing I was curious about is - do you see savings when
> you pin the rcu threads to the LITTLE CPUs of the system? The theory
> being, not disturbing the BIG CPUs which are more power hungry may let
> them go into a deeper idle state and save power (due to leakage
> current and so forth).
> 
I did some experimenting to pin nocbs to a little cluster. For idle use
cases i did not see any power gain. For heavy one i see that "big" CPUs
are also invoking and busy with it quite often. Probably i should think
of some use case where i can detect the power difference. If you have
something please let me know.

> > So a front-lazy-batching is something worth to have, IMHO :)
> 
> Exciting! Being lazy pays off some times ;-) ;-). If you are Ok with
> it, we can add your data to the LPC slides as well about your
> investigation (with attribution to you).
> 
No problem, since we will give a talk on LPC, more data we have more
convincing we are :)

--
Uladzislau Rezki

--+p1/KCQbdo0Dd/Ot
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="perf_script_parser.c"

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <ctype.h>
#include <string.h>

/*
 * Splay-tree implementation to store data: key,value
 * See https://en.wikipedia.org/wiki/Splay_tree
 */
#define offsetof(TYPE, MEMBER)	((unsigned long)&((TYPE *)0)->MEMBER)
#define container_of(ptr, type, member)			\
({												\
	void *__mptr = (void *)(ptr);					\
	((type *)(__mptr - offsetof(type, member)));	\
})

#define SP_INIT_NODE(node)									\
	((node)->left = (node)->right = (node)->parent = NULL)

struct splay_node {
	struct splay_node *left;
	struct splay_node *right;
	struct splay_node *parent;
	unsigned long val;
};

struct splay_root {
	struct splay_node *sp_root;
};

static inline void
set_parent(struct splay_node *n, struct splay_node *p)
{
	if (n)
		n->parent = p;
}

static inline void
change_child(struct splay_node *p,
	struct splay_node *old, struct splay_node *new)
{
	if (p) {
		if (p->left == old)
			p->left = new;
		else
			p->right = new;
	}
}

/*
 * left rotation of node (r), (rc) is (r)'s right child
 */
static inline struct splay_node *
left_pivot(struct splay_node *r)
{
	struct splay_node *rc;

	/*
	 * set (rc) to be the new root
	 */
	rc = r->right;

	/*
	 * point parent to new left/right child
	 */
	rc->parent = r->parent;

	/*
	 * change child of the p->parent.
	 */
	change_child(r->parent, r, rc);

	/*
	 * set (r)'s right child to be (rc)'s left child
	 */
	r->right = rc->left;

	/*
	 * change parent of rc's left child
	 */
	set_parent(rc->left, r);

	/*
	 * set new parent of rotated node
	 */
	r->parent = rc;

	/*
	 * set (rc)'s left child to be (r)
	 */
	rc->left = r;

	/*
	 * return the new root
	 */
	return rc;
}

/*
 * right rotation of node (r), (lc) is (r)'s left child
 */
static inline struct splay_node *
right_pivot(struct splay_node *r)
{
	struct splay_node *lc;

	/*
	 * set (lc) to be the new root
	 */
	lc = r->left;

	/*
	 * point parent to new left/right child
	 */
	lc->parent = r->parent;

	/*
	 * change child of the p->parent.
	 */
	change_child(r->parent, r, lc);

	/*
	 * set (r)'s left child to be (lc)'s right child
	 */
	r->left = lc->right;

	/*
	 * change parent of lc's right child
	 */
	set_parent(lc->right, r);

	/*
	 * set new parent of rotated node
	 */
	r->parent = lc;

	/*
	 * set (lc)'s right child to be (r)
	 */
	lc->right = r;

	/*
	 * return the new root
	 */
	return lc;
}

static struct splay_node *
top_down_splay(unsigned long vstart,
	struct splay_node *root, struct splay_root *sp_root)
{
	/*
	 * During the splitting process two temporary trees are formed.
	 * "l" contains all keys less than the search key/vstart and "r"
	 * contains all keys greater than the search key/vstart.
	 */
	struct splay_node head, *ltree_max, *rtree_max;
	struct splay_node *ltree_prev, *rtree_prev;

	if (root == NULL)
		return NULL;

	SP_INIT_NODE(&head);
	ltree_max = rtree_max = &head;
	ltree_prev = rtree_prev = NULL;

	while (1) {
		if (vstart < root->val && root->left) {
			if (vstart < root->left->val) {
				root = right_pivot(root);

				if (root->left == NULL)
					break;
			}

			/*
			 * Build right subtree.
			 */
			rtree_max->left = root;
			rtree_max->left->parent = rtree_prev;
			rtree_max = rtree_max->left;
			rtree_prev = root;
			root = root->left;
		} else if (vstart > root->val && root->right) {
			if (vstart > root->right->val) {
				root = left_pivot(root);

				if (root->right == NULL)
					break;
			}

			/*
			 * Build left subtree.
			 */
			ltree_max->right = root;
			ltree_max->right->parent = ltree_prev;
			ltree_max = ltree_max->right;
			ltree_prev = root;
			root = root->right;
		} else {
			break;
		}
	}

	/*
	 * Assemble the tree.
	 */
	ltree_max->right = root->left;
	rtree_max->left = root->right;
	root->left = head.right;
	root->right = head.left;

	set_parent(ltree_max->right, ltree_max);
	set_parent(rtree_max->left, rtree_max);
	set_parent(root->left, root);
	set_parent(root->right, root);
	root->parent = NULL;

	/*
	 * Set new root. Please note it might be the same.
	 */
	sp_root->sp_root = root;
	return sp_root->sp_root;
}

struct splay_node *
splay_search(unsigned long key, struct splay_root *root)
{
	struct splay_node *n;

	n = top_down_splay(key, root->sp_root, root);
	if (n && n->val == key)
		return n;

	return NULL;
}

static bool
splay_insert(struct splay_node *n, struct splay_root *sp_root)
{
	struct splay_node *r;

	SP_INIT_NODE(n);

	r = top_down_splay(n->val, sp_root->sp_root, sp_root);
	if (r == NULL) {
		/* First element in the tree */
		sp_root->sp_root = n;
		return false;
	}

	if (n->val < r->val) {
		n->left = r->left;
		n->right = r;

		set_parent(r->left, n);
		r->parent = n;
		r->left = NULL;
	} else if (n->val > r->val) {
		n->right = r->right;
		n->left = r;

		set_parent(r->right, n);
		r->parent = n;
		r->right = NULL;
	} else {
		/*
		 * Same, indicate as not success insertion.
		 */
		return false;
	}

	sp_root->sp_root = n;
	return true;
}

static bool
splay_delete_init(struct splay_node *n, struct splay_root *sp_root)
{
	struct splay_node *subtree[2];
	unsigned long val = n->val;

	/* 1. Splay the node to the root. */
	n = top_down_splay(n->val, sp_root->sp_root, sp_root);
	if (n == NULL || n->val != val)
		return false;

	/* 2. Save left/right sub-trees. */
	subtree[0] = n->left;
	subtree[1] = n->right;

	/* 3. Now remove the node. */
	SP_INIT_NODE(n);

	if (subtree[0]) {
		/* 4. Splay the largest node in left sub-tree to the root. */
		top_down_splay(val, subtree[0], sp_root);

		/* 5. Attach the right sub-tree as the right child of the left sub-tree. */
		sp_root->sp_root->right = subtree[1];

		/* 6. Update the parent of right sub-tree */
		set_parent(subtree[1], sp_root->sp_root);
	} else {
		/* 7. Left sub-tree is NULL, just point to right one. */
		sp_root->sp_root = subtree[1];
	}

	/* 8. Set parent of root node to NULL. */
	if (sp_root->sp_root)
		sp_root->sp_root->parent = NULL;

	return true;
}

static FILE *
open_perf_script_file(const char *path)
{
	FILE *f = NULL;

	if (path == NULL)
		goto out;

	f = fopen(path, "r");
	if (!f)
		goto out;

out:
	return f;
}

static int
get_one_line(FILE *file, char *buf, size_t len)
{
	int i = 0;

	memset(buf, '\0', len);

	for (i = 0; i < len - 1; i++) {
		int c = fgetc(file);

		if (c == EOF)
			return EOF;

		if (c == '\n')
			break;

		if (c != '\r')
			buf[i] = c;
	}

	return i;
}

static int
read_string_till_string(char *buf, char *out, size_t out_len, char *in, size_t in_len)
{
	int i, j;

	memset(out, '\0', out_len);

	for (i = 0; i < out_len; i++) {
		if (buf[i] != in[0]) {
			out[i] = buf[i];
			continue;
		}

		for (j = 0; j < in_len; j++) {
			if (buf[i + j] != in[j])
				break;
		}

		/* Found. */
		if (j == in_len)
			return 1;
	}

	return 0;
}

/*
 * find pattern is  "something [003] 8640.034785: something"
 */
static inline void
get_cpu_sec_usec_in_string(const char *s, int *cpu, int *sec, int *usec)
{
	char usec_buf[32] = {'\0'};
	char sec_buf[32] = {'\0'};
	char cpu_buf[32] = {'\0'};
	bool found_sec = false;
	bool found_usec = false;
	bool found_cpu = false;
	int i, j, dot;

	*cpu = *sec = *usec = -1;

	for (i = 0, j = 0; s[i] != '\0'; i++) {
		if (s[i] == '.') {
			dot = i++;

			/* take microseconds */
			for (j = 0; j < sizeof(usec_buf); j++) {
				if (isdigit(s[i])) {
					usec_buf[j] = s[i];
				} else {
					if (s[i] == ':' && j > 0)
						found_usec = true;
					else
						found_usec = false;

					/* Terminate here. */
					break;
				}

				i++;
			}

			if (found_usec) {
				/* roll back */
				while (s[i] != ' ' && i > 0)
					i--;

				/* take seconds */
				for (j = 0; j < sizeof(sec_buf); j++) {
					if (isdigit(s[++i])) {
						sec_buf[j] = s[i];
					} else {
						if (s[i] == '.' && j > 0)
							found_sec = true;
						else
							found_sec = false;
						
						/* Terminate here. */
						break;
					}
				}
			}

			if (found_sec && found_usec) {
				/* roll back */
				while (s[i] != '[' && i > 0)
					i--;

				/* take seconds */
				for (j = 0; j < sizeof(cpu_buf); j++) {
					if (isdigit(s[++i])) {
						cpu_buf[j] = s[i];
					} else {
						if (s[i] == ']' && j > 0)
							found_cpu = true;
						else
							found_cpu = false;
						
						/* Terminate here. */
						break;
					}
				}

				if (found_cpu && found_sec && found_usec) {
					*sec = atoi(sec_buf);
					*usec = atoi(usec_buf);
					*cpu = atoi(cpu_buf);
					return;
				}
			}

			/*
			 * Check next dot pattern.
			 */
			found_sec = false;
			found_usec = false;
			found_cpu = false;
			i = dot;
		}
	}
}

/*
 * find pattern is  "something comm=foo android thr1 pid=123 something"
 */
static inline int
get_comm_pid_in_string(const char *buf, char *comm, ssize_t len, int *pid)
{
	char *sc, *sp;
	int rv, i;

	memset(comm, '\0', len);

	sc = strstr(buf, "comm=");
	if (sc)
		sp = strstr(sc, " pid=");

	if (!sc || !sp)
		return -1;

	for (i = 0, sc += 5; sc != sp; i++) {
		if (i < len) {
			if (*sc == ' ')
				comm[i] = '-';
			else
				comm[i] = *sc;

			sc++;
		}
	}

	/* Read pid. */
	rv = sscanf(sp, " pid=%d", pid);
	if (rv != 1)
		return -1;

	return 1;
}

static void
perf_script_softirq_delay(FILE *file, int delay_usec)
{
	char buf[4096] = { '\0' };
	char buf_1[4096] = { '\0' };
	long offset;
	char *s;
	int rv;

	while (1) {
		rv = get_one_line(file, buf, sizeof(buf));
		offset = ftell(file);

		if (rv != EOF) {
			s = strstr(buf, "irq:softirq_raise:");
			if (s) {
				char extra[512] = {'\0'};
				int sec_0, usec_0;
				int sec_1, usec_1;
				int handle_vector;
				int rise_vector;
				int cpu_0;
				int cpu_1;

				/*
				 * swapper     0    [000]  6010.619854:  irq:softirq_raise: vec=7 [action=SCHED]
				 * android.bg  3052 [001]  6000.076212:  irq:softirq_entry: vec=9 [action=RCU]
				 */
				(void) sscanf(s, "%s vec=%d", extra, &rise_vector);
				get_cpu_sec_usec_in_string(buf, &cpu_0, &sec_0, &usec_0);

				while (1) {
					rv = get_one_line(file, buf_1, sizeof(buf_1));
					if (rv == EOF)
						break;

					s = strstr(buf_1, "irq:softirq_entry:");
					if (s) {
						(void) sscanf(s, "%s vec=%d", extra, &handle_vector);
						get_cpu_sec_usec_in_string(buf_1, &cpu_1, &sec_1, &usec_1);

						if (cpu_0 == cpu_1 && rise_vector == handle_vector) {
							int delta_time_usec = (sec_1 - sec_0) * 1000000 + (usec_1 - usec_0);

							if (delta_time_usec > delay_usec)
								fprintf(stdout, "{\n%s\n%s\n} diff %d usec\n", buf, buf_1, delta_time_usec);
							break;
						}
					}
				}
			}

			rv = fseek(file, offset, SEEK_SET);
			if (rv)
				fprintf(stdout, "fseek error !!!\n");
		} else {
			break;
		}
	}
}

static void
perf_script_softirq_duration(FILE *file, int duration_usec)
{
	char buf[4096] = { '\0' };
	char buf_1[4096] = { '\0' };
	long offset;
	char *s;
	int rv;

	while (1) {
		rv = get_one_line(file, buf, sizeof(buf));
		offset = ftell(file);

		if (rv != EOF) {
			s = strstr(buf, "irq:softirq_entry:");
			if (s) {
				char extra[512] = {'\0'};
				int sec_0, usec_0;
				int sec_1, usec_1;
				int handle_vector;
				int rise_vector;
				int cpu_0;
				int cpu_1;

				/*
				 * swapper     0    [000]  6010.619854:  irq:softirq_entry: vec=7 [action=SCHED]
				 * android.bg  3052 [001]  6000.076212:  irq:softirq_exit: vec=9 [action=RCU]
				 */
				(void) sscanf(s, "%s vec=%d", extra, &rise_vector);
				get_cpu_sec_usec_in_string(buf, &cpu_0, &sec_0, &usec_0);

				while (1) {
					rv = get_one_line(file, buf_1, sizeof(buf_1));
					if (rv == EOF)
						break;

					s = strstr(buf_1, "irq:softirq_exit:");
					if (s) {
						(void) sscanf(s, "%s vec=%d", extra, &handle_vector);
						get_cpu_sec_usec_in_string(buf_1, &cpu_1, &sec_1, &usec_1);

						if (cpu_0 == cpu_1 && rise_vector == handle_vector) {
							int delta_time_usec = (sec_1 - sec_0) * 1000000 + (usec_1 - usec_0);

							if (delta_time_usec > duration_usec)
								fprintf(stdout, "{\n%s\n%s\n} diff %d usec\n", buf, buf_1, delta_time_usec);
							break;
						}
					}
				}
			}

			rv = fseek(file, offset, SEEK_SET);
			if (rv)
				fprintf(stdout, "fseek error !!!\n");
		} else {
			break;
		}
	}
}

static void
perf_script_hardirq_duration(FILE *file, int duration_msec)
{
	char buf[4096] = { '\0' };
	char buf_1[4096] = { '\0' };
	long offset;
	char *s;
	int rv;

	while (1) {
		rv = get_one_line(file, buf, sizeof(buf));
		offset = ftell(file);

		if (rv != EOF) {
			s = strstr(buf, "irq:irq_handler_entry:");
			if (s) {
				char extra[512] = {'\0'};
				int sec_0, usec_0;
				int sec_1, usec_1;
				int handle_vector;
				int rise_vector;
				int cpu_0;
				int cpu_1;

				/*
				 * swapper     0 [002]  6205.804133: irq:irq_handler_entry: irq=11 name=arch_timer
				 * swapper     0 [002]  6205.804228:  irq:irq_handler_exit: irq=11 ret=handled
				 */
				(void) sscanf(s, "%s irq=%d", extra, &rise_vector);
				get_cpu_sec_usec_in_string(buf, &cpu_0, &sec_0, &usec_0);

				while (1) {
					rv = get_one_line(file, buf_1, sizeof(buf_1));
					if (rv == EOF)
						break;

					s = strstr(buf_1, "irq:irq_handler_exit:");
					if (s) {
						(void) sscanf(s, "%s irq=%d", extra, &handle_vector);
						get_cpu_sec_usec_in_string(buf_1, &cpu_1, &sec_1, &usec_1);

						if (cpu_0 == cpu_1 && rise_vector == handle_vector) {
							int delta_time_usec = (sec_1 - sec_0) * 1000000 + (usec_1 - usec_0);

							if (delta_time_usec > duration_msec)
								fprintf(stdout, "{\n%s\n%s\n} diff %d usec\n", buf, buf_1, delta_time_usec);
							break;
						}
					}
				}
			}

			rv = fseek(file, offset, SEEK_SET);
			if (rv)
				fprintf(stdout, "fseek error !!!\n");
		} else {
			break;
		}
	}
}

struct irq_stat {
	int irq;
	int count;
	char irq_name[512];

	int min_interval;
	int max_interval;
	int avg_interval;

	unsigned int time_stamp_usec;
	struct splay_node node;
};

static struct irq_stat *
new_irq_node_init(int irq, char *irq_name)
{
	struct irq_stat *n = calloc(1, sizeof(*n));

	if (n) {
		n->irq = irq;
		(void) strncpy(n->irq_name, irq_name, sizeof(n->irq_name));
		n->node.val = irq;
	}

	return n;
}

static void
perf_script_hardirq_stat(FILE *file)
{
	struct splay_root sproot = { NULL };
	struct irq_stat *node;
	char buf[4096] = { '\0' };
	char extra[256] = {'\0'};
	char irq_name[256] = {'\0'};
	unsigned int time_stamp_usec;
	int cpu, sec, usec;
	int rv, irq;
	char *s;

	while (1) {
		rv = get_one_line(file, buf, sizeof(buf));
		if (rv == EOF)
			break;

		 s = strstr(buf, "irq:irq_handler_entry:");
		 if (s == NULL)
			 continue;

		 /*
		  * format is as follow one:
		  * sleep  1418 [003]  8780.957112:             irq:irq_handler_entry: irq=11 name=arch_timer
		  */
		 rv = sscanf(s, "%s irq=%d name=%s", extra, &irq, irq_name);
	 	 if (rv != 3)
	 		 continue;

		 get_cpu_sec_usec_in_string(buf, &cpu, &sec, &usec);
		 time_stamp_usec = (sec * 1000000) + usec;

		 if (sproot.sp_root == NULL) {
			 node = new_irq_node_init(irq, irq_name);
			 if (node)
				 splay_insert(&node->node, &sproot);
		 }

		 top_down_splay(irq, sproot.sp_root, &sproot);
		 node = container_of(sproot.sp_root, struct irq_stat, node);

		 /* Found the entry in the tree. */
		 if (node->irq == irq) {
			 if (node->time_stamp_usec) {
				 unsigned int delta = time_stamp_usec - node->time_stamp_usec;

				 if (delta < node->min_interval || !node->min_interval)
					 node->min_interval = delta;

				 if (delta > node->max_interval)
					 node->max_interval = delta;

				 node->avg_interval += delta;
			 }

			 /* Save the last time for this IRQ entry. */
			 node->time_stamp_usec = time_stamp_usec;
		 } else {
			 /* Allocate a new record and place it to the tree. */
			 node = new_irq_node_init(irq, irq_name);
			 if (node)
				 splay_insert(&node->node, &sproot);

		 }

		 /* Update the timestamp for this entry. */
		 node->time_stamp_usec = time_stamp_usec;
		 node->count++;
	}

	/* Dump the tree. */
	while (sproot.sp_root) {
		node = container_of(sproot.sp_root, struct irq_stat, node);

		fprintf(stdout, "irq: %5d name: %30s count: %7d, min: %10d, max: %10d, avg: %10d\n",
				node->irq, node->irq_name, node->count,
				node->min_interval, node->max_interval, node->avg_interval / node->count);

		splay_delete_init(&node->node, &sproot);
		free(node);
	}

	fprintf(stdout, "\tRun './a.out ./perf.script | sort -nk 6' to sort by column 6.\n");
}

struct sched_waking {
	unsigned int wakeup_nr;
	char comm[4096];
	int pid;

	int min_interval;
	int max_interval;
	int avg_interval;

	unsigned int time_stamp_usec;
	struct splay_node node;
};

static struct sched_waking *
new_sched_waking_node_init(int pid, char *comm)
{
	struct sched_waking *n = calloc(1, sizeof(*n));

	if (n) {
		n->pid = pid;
		(void) strncpy(n->comm, comm, sizeof(n->comm));
		n->node.val = pid;
	}

	return n;
}

static void
perf_script_sched_waking_stat(FILE *file, const char *script)
{
	struct splay_root sroot = { NULL };
	struct sched_waking *n;
	char buf[4096] = { '\0' };
	char comm[256] = {'\0'};
	unsigned int time_stamp_usec;
	unsigned int total_waking = 0;
	int cpu, sec, usec;
	int rv, pid;
	char *s;
	
	while (1) {
		rv = get_one_line(file, buf, sizeof(buf));
		if (rv == EOF)
			break;
		/*
		 * format is as follow one:
		 * foo[1] 7521 [002] 10.431216: sched:sched_waking: comm=tr pid=2 prio=120 target_cpu=006
		 */
		s = strstr(buf, "sched:sched_waking:");
		if (s == NULL)
			continue;

		rv = get_comm_pid_in_string(s, comm, sizeof(comm), &pid);
		if (rv < 0) {
			printf("ERROR: skip entry...\n");
			continue;
		}

		get_cpu_sec_usec_in_string(buf, &cpu, &sec, &usec);
		time_stamp_usec = (sec * 1000000) + usec;

		if (sroot.sp_root == NULL) {
			n = new_sched_waking_node_init(pid, comm);
			if (n)
				splay_insert(&n->node, &sroot);
		}

		top_down_splay(pid, sroot.sp_root, &sroot);
		n = container_of(sroot.sp_root, struct sched_waking, node);

		/* Found the entry in the tree. */
		if (n->pid == pid) {
			if (n->time_stamp_usec) {
				unsigned int delta = time_stamp_usec - n->time_stamp_usec;

				if (delta < n->min_interval || !n->min_interval)
					n->min_interval = delta;

				if (delta > n->max_interval)
					n->max_interval = delta;

				n->avg_interval += delta;
			}

			/* Save the last time for this wake-up entry. */
			n->time_stamp_usec = time_stamp_usec;
		} else {
			/* Allocate a new record and place it to the tree. */
			n = new_sched_waking_node_init(pid, comm);
			if (n)
				splay_insert(&n->node, &sroot);
		}

		/* Update the timestamp for this entry. */
		n->time_stamp_usec = time_stamp_usec;
		n->wakeup_nr++;
	}

	/* Dump the Splay-tree. */
	while (sroot.sp_root) {
		n = container_of(sroot.sp_root, struct sched_waking, node);
		fprintf(stdout, "name: %30s pid: %10d woken-up %5d\tinterval: min %5d\tmax %5d\tavg %5d\n",
			n->comm, n->pid, n->wakeup_nr,
			n->min_interval, n->max_interval, n->avg_interval / n->wakeup_nr);

		total_waking += n->wakeup_nr;
		splay_delete_init(&n->node, &sroot);
		free(n);
	}

	fprintf(stdout, "=== Total: %u ===\n", total_waking);
	fprintf(stdout, "\tRun './a.out ./%s | sort -nk 6' to sort by column 6.\n", script);
}

int main(int argc, char **argv)
{
	FILE *file;

	file = open_perf_script_file(argv[1]);
	if (file == NULL) {
		fprintf(stdout, "%s:%d failed: specify a perf script file\n", __func__, __LINE__);
		exit(-1);
	}

	/* perf_script_softirq_delay(file, 1000); */
	/* perf_script_softirq_duration(file, 500); */
	/* perf_script_hardirq_duration(file, 500); */
	/* perf_script_hardirq_stat(file); */
	perf_script_sched_waking_stat(file, argv[1]);

	return 0;
}

--+p1/KCQbdo0Dd/Ot--
