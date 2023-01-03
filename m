Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236C2C3DA7D
	for <rcu@archiver.kernel.org>; Tue,  3 Jan 2023 17:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjACR5d (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Jan 2023 12:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbjACR5I (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Jan 2023 12:57:08 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2510011472
        for <rcu@vger.kernel.org>; Tue,  3 Jan 2023 09:57:07 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id g7so25141388qts.1
        for <rcu@vger.kernel.org>; Tue, 03 Jan 2023 09:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ixGyFkrV0xqrkiJ3p7VqvfkszCi48OTsH11wl3xFQLU=;
        b=sRUosVhssD0en5joF9vLLUpX8V0Mn5UlDYOilUJ2tyvRYgMexyinwnRJCc3npDcj9I
         geM1NnHZAfGfSpvgKWqCzimVnD6QWlnqEenqostnemsBY4KDrX8lFXhtceyrzwT9moVs
         Jc1VYidMjKKFAdRJEyu7HFp5pWDwhhcubFJ1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixGyFkrV0xqrkiJ3p7VqvfkszCi48OTsH11wl3xFQLU=;
        b=vDDnIxjjou2vy0neMyFzpcWycJmG1P58gkFKxIsqkI+7J+iVjWin4uijdKrq+lbsAw
         4LWDOuS6tES+cwz/pijMhqIXZ9RBu3kzJkXbwMtCUJIuC+vIzjKKLPWHjbEUZWAtDL+i
         wIpftwv0odOTVnKu07tKpBlyuQgo4mw17BmfnomWldjdE01R/SSFY0cSxka+/F/BOeUs
         O56vsjo33QXpKXQeX6Qptz7WRmUj0/FDTp18UEyyM3l+vjNtJIoMy0vPZ41XRA8OshQP
         D1Yf/FtDKyq+d+FIQz60WcThzwb8vJEox9VYGKjgGpt1dNSNZBtcYLAtmk3XyQvAYQVQ
         zi7Q==
X-Gm-Message-State: AFqh2ko3N5pmnvsSWCwlGq3i6a4hAEU6otFWfPpEZZ/sJPkctNCRNLtB
        01WIFI+jIvUTZxn7iVE0W0s7Tw==
X-Google-Smtp-Source: AMrXdXv19UfqJyggz6tYWC0TuSnV2Pq7G45UznkmBJIcBdaSQp4fc0yOJ0tlHOvTs2CpB4BwE5SVhg==
X-Received: by 2002:ac8:4602:0:b0:3ab:6312:f306 with SMTP id p2-20020ac84602000000b003ab6312f306mr64154599qtn.4.1672768626223;
        Tue, 03 Jan 2023 09:57:06 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id d21-20020ac86695000000b0038b684a1642sm19136842qtp.32.2023.01.03.09.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 09:57:05 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, neeraj.iitr10@gmail.com
Subject: [PATCH v3] srcu: Remove memory barrier "E" as it does not do anything
Date:   Tue,  3 Jan 2023 17:56:54 +0000
Message-Id: <20230103175654.1913192-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

During a flip, we have a full memory barrier before srcu_idx is incremented.

The idea is we intend to order the first phase scan's read of lock
counters with the flipping of the index.

However, such ordering is already enforced because of the
control-dependency between the 2 scans. We would be flipping the index
only if lock and unlock counts matched.

But such match will not happen if there was a pending reader before the flip
in the first place (observation courtesy Mathieu Desnoyers).

The litmus test below shows this:
(test courtesy Frederic Weisbecker, Changes for ctrldep by Boqun/me):

C srcu
(*
 * bad condition: P0's first scan (SCAN1) saw P1's idx=0 LOCK count inc, though P1 saw flip.
 *
 * So basically, the ->po ordering on both P0 and P1 is enforced via ->ppo
 * (control deps) on both sides, and both P0 and P1 are interconnected by ->rf
 * relations. Combining the ->ppo with ->rf, a cycle is impossible.
 *)

{}

// updater
P0(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
{
        int lock1;
        int unlock1;
        int lock0;
        int unlock0;

        // SCAN1
        unlock1 = READ_ONCE(*UNLOCK1);
        smp_mb(); // A
        lock1 = READ_ONCE(*LOCK1);

        // FLIP
        if (lock1 == unlock1) {   // Control dep
                smp_mb(); // E    // Remove E and still passes.
                WRITE_ONCE(*IDX, 1);
                smp_mb(); // D

                // SCAN2
                unlock0 = READ_ONCE(*UNLOCK0);
                smp_mb(); // A
                lock0 = READ_ONCE(*LOCK0);
        }
}

// reader
P1(int *IDX, int *LOCK0, int *UNLOCK0, int *LOCK1, int *UNLOCK1)
{
        int tmp;
        int idx1;
        int idx2;

        // 1st reader
        idx1 = READ_ONCE(*IDX);
        if (idx1 == 0) {         // Control dep
                tmp = READ_ONCE(*LOCK0);
                WRITE_ONCE(*LOCK0, tmp + 1);
                smp_mb(); /* B and C */
                tmp = READ_ONCE(*UNLOCK0);
                WRITE_ONCE(*UNLOCK0, tmp + 1);
        } else {
                tmp = READ_ONCE(*LOCK1);
                WRITE_ONCE(*LOCK1, tmp + 1);
                smp_mb(); /* B and C */
                tmp = READ_ONCE(*UNLOCK1);
                WRITE_ONCE(*UNLOCK1, tmp + 1);
        }
}

exists (0:lock1=1 /\ 1:idx1=1)

This commit therefore removes memory barrier E, as memory barriers are not
free, and clarifies the old comment.

Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Co-developed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
v1->v2: Update changelog, keep old comments.
v2->v3: Moar changelog updates.


 kernel/rcu/srcutree.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 1c304fec89c0..0f9ba0f9fd12 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -983,15 +983,15 @@ static bool try_check_zero(struct srcu_struct *ssp, int idx, int trycount)
 static void srcu_flip(struct srcu_struct *ssp)
 {
 	/*
-	 * Ensure that if this updater saw a given reader's increment
-	 * from __srcu_read_lock(), that reader was using an old value
-	 * of ->srcu_idx.  Also ensure that if a given reader sees the
-	 * new value of ->srcu_idx, this updater's earlier scans cannot
-	 * have seen that reader's increments (which is OK, because this
-	 * grace period need not wait on that reader).
+	 * Control dependencies on both reader and updater side ensures that if
+	 * this updater saw a given reader's increment from __srcu_read_lock(),
+	 * that reader was using an old value of ->srcu_idx.  Also ensures that
+	 * if a given reader sees the new value of ->srcu_idx, this updater's
+	 * earlier scans cannot have seen that reader's increments (which is
+	 * OK, because this grace period need not wait on that reader).
+	 *
+	 * So no need for an smp_mb() before incrementing srcu_idx.
 	 */
-	smp_mb(); /* E */  /* Pairs with B and C. */
-
 	WRITE_ONCE(ssp->srcu_idx, ssp->srcu_idx + 1);
 
 	/*
-- 
2.39.0.314.g84b9a713c41-goog
