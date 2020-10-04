Return-Path: <SRS0=q59W=DL=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC28C41604
	for <rcu@archiver.kernel.org>; Sun,  4 Oct 2020 00:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7233206C9
	for <rcu@archiver.kernel.org>; Sun,  4 Oct 2020 00:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgJDASP (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 3 Oct 2020 20:18:15 -0400
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:58244 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726108AbgJDASP (ORCPT
        <rfc822;rcu@vger.kernel.org>); Sat, 3 Oct 2020 20:18:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id DF96F180A7FE1;
        Sun,  4 Oct 2020 00:18:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hall06_1c073fd271b1
X-Filterd-Recvd-Size: 1595
Received: from joe-laptop.perches.com (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sun,  4 Oct 2020 00:18:11 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, rcu@vger.kernel.org,
        linux-mm@kvack.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] treewide: Make definitions of struct kernel_param_ops const
Date:   Sat,  3 Oct 2020 17:18:05 -0700
Message-Id: <cover.1601770305.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Using const is good as it reduces data size.

Joe Perches (4):
  KVM: PPC: Book3S HV: Make struct kernel_param_ops definition const
  kvm x86/mmu: Make struct kernel_param_ops definitions const
  rcu/tree: Make struct kernel_param_ops definitions const
  mm/zswap: Make struct kernel_param_ops definitions const

 arch/powerpc/kvm/book3s_hv.c | 2 +-
 arch/x86/kvm/mmu/mmu.c       | 4 ++--
 kernel/rcu/tree.c            | 4 ++--
 mm/zswap.c                   | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.26.0

