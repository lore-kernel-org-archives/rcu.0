Return-Path: <SRS0=yil3=5C=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C0BC10F29
	for <rcu@archiver.kernel.org>; Tue, 17 Mar 2020 16:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7842073E
	for <rcu@archiver.kernel.org>; Tue, 17 Mar 2020 16:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584463503;
	bh=cBMVgSpnWq79rXyBXbwVtrgJxTA5gt9Nbc6cBfcAaoQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=gU/iVNuKU/CXluiU5RFUqzpRO0++IIhnDtxGee2/tOa4sQhu0DYufg40LdHo84suX
	 Jicr/S3obcTDxAa8BoEVKMQ936ljEsCqKig/E5fehYaKGgYyBrpItj0ceO9C9X2w6u
	 1nzjP6RHi/WDSyrsfThAn5aNqu1o4np7ekXQCVrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgCQQpD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgCQQpD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 17 Mar 2020 12:45:03 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AB7920735;
        Tue, 17 Mar 2020 16:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584463502;
        bh=cBMVgSpnWq79rXyBXbwVtrgJxTA5gt9Nbc6cBfcAaoQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PbNAsvmR9WWkfg8v2Zjs8qzl7S6PN5Pt3pTYzv6J7VNeQz3vhwqBbx3qliyWJP5qQ
         Z9bZV1TYs0hjbYRlDvuRvFDTnJNbtxx0Cf4/pK1T5Ph44gFkgJwLZ7Oq9U1hcQz/i8
         8lmQ2lTbQyiAPzxkPbK93NbBgJXA18jEfUR0wXyE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BFC9635226E2; Tue, 17 Mar 2020 09:45:01 -0700 (PDT)
Date:   Tue, 17 Mar 2020 09:45:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 09/17] rcu: update.c: get rid of some doc warnings
Message-ID: <20200317164501.GG3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
 <c69a85d13717c2aec563f702bffd7cd1e3be6a88.1584456635.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c69a85d13717c2aec563f702bffd7cd1e3be6a88.1584456635.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Mar 17, 2020 at 03:54:18PM +0100, Mauro Carvalho Chehab wrote:
> We need to escape *ret, as otherwise the documentation system
> thinks that this is an incomplete emphasis block:
> 
> 	./kernel/rcu/update.c:65: WARNING: Inline emphasis start-string without end-string.
> 	./kernel/rcu/update.c:65: WARNING: Inline emphasis start-string without end-string.
> 	./kernel/rcu/update.c:70: WARNING: Inline emphasis start-string without end-string.
> 	./kernel/rcu/update.c:82: WARNING: Inline emphasis start-string without end-string.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Applied, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/update.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index b1fa519e5890..16058a5e6da4 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -63,12 +63,12 @@ module_param(rcu_normal_after_boot, int, 0);
>   * rcu_read_lock_held_common() - might we be in RCU-sched read-side critical section?
>   * @ret:	Best guess answer if lockdep cannot be relied on
>   *
> - * Returns true if lockdep must be ignored, in which case *ret contains
> + * Returns true if lockdep must be ignored, in which case ``*ret`` contains
>   * the best guess described below.  Otherwise returns false, in which
> - * case *ret tells the caller nothing and the caller should instead
> + * case ``*ret`` tells the caller nothing and the caller should instead
>   * consult lockdep.
>   *
> - * If CONFIG_DEBUG_LOCK_ALLOC is selected, set *ret to nonzero iff in an
> + * If CONFIG_DEBUG_LOCK_ALLOC is selected, set ``*ret`` to nonzero iff in an
>   * RCU-sched read-side critical section.  In absence of
>   * CONFIG_DEBUG_LOCK_ALLOC, this assumes we are in an RCU-sched read-side
>   * critical section unless it can prove otherwise.  Note that disabling
> @@ -82,7 +82,7 @@ module_param(rcu_normal_after_boot, int, 0);
>   *
>   * Note that if the CPU is in the idle loop from an RCU point of view (ie:
>   * that we are in the section between rcu_idle_enter() and rcu_idle_exit())
> - * then rcu_read_lock_held() sets *ret to false even if the CPU did an
> + * then rcu_read_lock_held() sets ``*ret`` to false even if the CPU did an
>   * rcu_read_lock().  The reason for this is that RCU ignores CPUs that are
>   * in such a section, considering these as in extended quiescent state,
>   * so such a CPU is effectively never in an RCU read-side critical section
> -- 
> 2.24.1
> 
