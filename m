Return-Path: <SRS0=RBzz=CJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6F5C433E6
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AE7F2083E
	for <rcu@archiver.kernel.org>; Mon, 31 Aug 2020 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598897017;
	bh=G1iH+/QCY280fAQFzIdvytLD1XQc88ODiVu9Ro09iw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sOka1WqGsUU3BKsdina/dIOj5NRJ2JfKt9M10kPQiVPMBkt9z+GAMtuFxfXP1lpnI
	 OwN9xSisOgn3VFqamk++m8ufyorbuPPm5CvVUvWyjf7EE6Tr5CTAXNMPUZNceqAEMx
	 cZqY39Fc3SkqrDqf9k7Tf8/XKvQgXopc2kJWKCh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgHaSC4 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbgHaSB0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:26 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E4432168B;
        Mon, 31 Aug 2020 18:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896885;
        bh=G1iH+/QCY280fAQFzIdvytLD1XQc88ODiVu9Ro09iw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DU8uCbCylnrnZOH8dD87Y+JCYVHjfpJYEwY5+H/xHHdfEmrR+irf4GbMQZ6sHgjcV
         78yp/HohQdx54beSNjuMFkBvuXtDaKBYL0tczVVeZ/F5YHyea6TlDDfdFornMLz9Bj
         fUdXBLg3+3KEXU+EYH5ease/PcanM7FNGpu5ofJ8=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, kvm@vger.kernel.org
Subject: [PATCH tip/core/rcu 17/24] kvm: mmu: page_track: Fix RCU list API usage
Date:   Mon, 31 Aug 2020 11:01:09 -0700
Message-Id: <20200831180116.32690-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180050.GA32590@paulmck-ThinkPad-P72>
References: <20200831180050.GA32590@paulmck-ThinkPad-P72>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Use hlist_for_each_entry_srcu() instead of hlist_for_each_entry_rcu()
as it also checkes if the right lock is held.
Using hlist_for_each_entry_rcu() with a condition argument will not
report the cases where a SRCU protected list is traversed using
rcu_read_lock(). Hence, use hlist_for_each_entry_srcu().

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: <kvm@vger.kernel.org>
---
 arch/x86/kvm/mmu/page_track.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
index a84a141..8443a67 100644
--- a/arch/x86/kvm/mmu/page_track.c
+++ b/arch/x86/kvm/mmu/page_track.c
@@ -229,7 +229,8 @@ void kvm_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
 		return;
 
 	idx = srcu_read_lock(&head->track_srcu);
-	hlist_for_each_entry_rcu(n, &head->track_notifier_list, node)
+	hlist_for_each_entry_srcu(n, &head->track_notifier_list, node,
+				srcu_read_lock_held(&head->track_srcu))
 		if (n->track_write)
 			n->track_write(vcpu, gpa, new, bytes, n);
 	srcu_read_unlock(&head->track_srcu, idx);
@@ -254,7 +255,8 @@ void kvm_page_track_flush_slot(struct kvm *kvm, struct kvm_memory_slot *slot)
 		return;
 
 	idx = srcu_read_lock(&head->track_srcu);
-	hlist_for_each_entry_rcu(n, &head->track_notifier_list, node)
+	hlist_for_each_entry_srcu(n, &head->track_notifier_list, node,
+				srcu_read_lock_held(&head->track_srcu))
 		if (n->track_flush_slot)
 			n->track_flush_slot(kvm, slot, n);
 	srcu_read_unlock(&head->track_srcu, idx);
-- 
2.9.5

