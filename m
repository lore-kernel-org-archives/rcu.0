Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B26D2652A2;
	Fri, 31 Jul 2026 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785459707; cv=none; b=B6N9GxfOarsFqr7treFy2gh/Rz65vjvPP2KfW6AHw256f3AW0U+XTLFJqkrxQdhfSBSD6SVjNAjKSZRlrfNNgY+TACdbViuARBrN4Ng2UppPkrkbNfPDyrpqDQ7l7rc7WsFRqdbr88ZDOSbe/wKH+5wMd8iUHcFfBBC3HPu/53w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785459707; c=relaxed/simple;
	bh=CG2dJD3/6q566sRXtx9PEgLWMD5LKg8r9offm0kQ+tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iocO1HGAnMs2n2kUd4PSCeckaTnPFjqMItU9IxPouy889Nrnpw2vGfoN8Pox19HjgCd5Otao5sX5y2/oBhZccaMW7GKjg2UAQtr0328UtAvAxPPGqE1VMGCU/0UVxljvAqK17BmJnV93CV9y95kqkX6ci7R2s14hHnIQpcTFnLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMyTai8/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMyTai8/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E521F000E9;
	Fri, 31 Jul 2026 01:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785459706;
	bh=Tse3E1ABf2F/h3hOTEoGLOo3rdvMOzqy5sCeAy5/mQU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=GMyTai8/h+q+ftv3CsSidMmdOLKH8gtUZra6L4w8eae4PBPjPkAAMPfNKrCqQcQnN
	 9uB13eB5FZf+a3xC6o7U5RsdIp2m0Uu7EzK/uM9/FOacRLFy2yCajNzkbtghgSsYA6
	 e2WSLEdPzAX4HMN5konBpHDqXYMVG17lf5JEpccp0YnT5UuqrMqzL87lX/Uf5lLqzL
	 lm49AZ8nXXUBLn6lp89zVE9Szx2IT8CBGppkRgxfGotTCN0EjVTh/rX1A1Jhcg1Xt8
	 hTNdkcLefp4JmJjWIcyM+gHgacDdesVj+mcu+l/ay+wnYVviIwlVGxRcnI/C5PoinE
	 qb08nICMtTYJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id CD4ECCE0F69; Thu, 30 Jul 2026 18:01:45 -0700 (PDT)
Date: Thu, 30 Jul 2026 18:01:45 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org
Subject: [PATCH v2 0/16] Miscellaneous RCU updates for v7.3
Message-ID: <9de287bc-e565-4f21-bd3c-5c17792e6abc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc69cc01-509e-43f8-a46a-d77946e7adc7@paulmck-laptop>

Hello!

This series contains v2 of miscellaneous RCU updates for v7.3:

1.	Use task_state_to_char() in stall-warning prints, courtesy of
	Kunwu Chan.

2.	Mark __rcu_access_pointer() as context_unsafe().

3.	RCU: Adopt new coding style of type-aware kmalloc-family -
	part 2/2, courtesy of Manuel Ebner.

4.	RCU: Fix brackets, courtesy of Manuel Ebner.

5.	introduce rcu_defer_qs_clear() helper, courtesy of Joel Fernandes.

6.	clear defer_qs_pending in deferred-QS bail when nesting > 0,
	courtesy of Joel Fernandes.

7.	Use this_cpu_{read,write}() for ->cpu_no_qs.b.exp.

8.	Use WRITE_ONCE() for ->rcu_need_heavy_qs.

9.	Remove unused expedited_need_qs field from rcu_state, courtesy
	of Joel Fernandes.

10.	Remove unused func parameter from callback-enqueue functions,
	courtesy of Joel Fernandes.

11.	Mark accesses to rdp->rcu_cpu_has_work.

12.	Mark interrupts-enabled accesses to rdp->cpu_no_qs.b.norm.

13.	Remove unused rdp parameter from rcu_check_gp_start_stall(),
	courtesy of Zqiang.

14.	Mark accesses to ->rcu_urgent_qs and ->rcu_need_heavy_qs,
	courtesy of Itai Handler.

15.	Reduce stack usage in show_rcu_gp_kthreads(), courtesy of Zqiang.

16.	Mark interrupts-enabled accesses to rdp->cpu_no_qs.s.

Changes since v1:

o	Added patches 12-16.

						Thanx, Paul

------------------------------------------------------------------------

 b/Documentation/RCU/Design/Expedited-Grace-Periods/Expedited-Grace-Periods.rst |    2 
 b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-gp.svg                      |    2 
 b/Documentation/RCU/Design/Memory-Ordering/TreeRCU-qs.svg                      |    2 
 b/Documentation/RCU/Design/Requirements/Requirements.rst                       |    2 
 b/Documentation/RCU/rcu_dereference.rst                                        |    4 
 b/include/linux/rcupdate.h                                                     |    4 
 b/kernel/rcu/tree.c                                                            |    3 
 b/kernel/rcu/tree.h                                                            |    5 
 b/kernel/rcu/tree_exp.h                                                        |    4 
 b/kernel/rcu/tree_nocb.h                                                       |    6 -
 b/kernel/rcu/tree_plugin.h                                                     |    4 
 b/kernel/rcu/tree_stall.h                                                      |   12 +-
 kernel/rcu/tree.c                                                              |   22 ++--
 kernel/rcu/tree.h                                                              |    6 -
 kernel/rcu/tree_plugin.h                                                       |   52 +++++++---
 kernel/rcu/tree_stall.h                                                        |   52 +++++-----
 16 files changed, 111 insertions(+), 71 deletions(-)
