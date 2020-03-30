Return-Path: <SRS0=wvKi=5P=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6F7C43331
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 21:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348132072D
	for <rcu@archiver.kernel.org>; Mon, 30 Mar 2020 21:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585602779;
	bh=OAGDkAeZxu6/Tty7FhrX3s15Q7/+hqQqbMiThptptzA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=u7vW7bUApQpfdq0Z5vTadV7mUWApCLkzSkm1CRQm9b+J5rB8tpwlG6OfPL3QlLdF5
	 hOc8pxP+IzouFhvq+FO+3fodT0Gfd+Zl2aAElkgvCmND6MX9Jtg/FayH26w2jpVXqp
	 oHlVYkG8HgudLIUpzaEZOR0tPivc1Qz38Vg0BYeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgC3VM7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728317AbgC3VM6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 30 Mar 2020 17:12:58 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02B9520714;
        Mon, 30 Mar 2020 21:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585602778;
        bh=OAGDkAeZxu6/Tty7FhrX3s15Q7/+hqQqbMiThptptzA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=KBAlovpJY+35SUzIFQj7VJvBe3c5yspm5axHiCCgoDntMppvDvmZ8Y2Ufm43Btnel
         7ewfDMAiE6RapChS/nbaOimCuQiYp8y/FE4azBhNSPfrECzdZnOxuQVvUnI3LpXDzl
         m7guBcp4dqZiDT55WDgaRzfpxIXiFPYBpdSVMYuo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C67D235229BC; Mon, 30 Mar 2020 14:12:57 -0700 (PDT)
Date:   Mon, 30 Mar 2020 14:12:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     julia.lawall@lip6.fr, boqun.feng@gmail.com,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "open list:READ-COPY UPDATE (RCU)" <rcu@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/10] rcu: Replace assigned pointer ret value by
 corresponding boolean value
Message-ID: <20200330211257.GP19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <0/10>
 <20200327212358.5752-1-jbi.octave@gmail.com>
 <20200327212358.5752-7-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327212358.5752-7-jbi.octave@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Mar 27, 2020 at 09:23:53PM +0000, Jules Irenge wrote:
> Coccinelle reports warnings at rcu_read_lock_held_common()
> 
> WARNING: Assignment of 0/1 to bool variable
> 
> To fix this,
> the assigned  pointer ret values are replaced by corresponding boolean value.
> Given that ret is a pointer of bool type
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Queued for further review and testing, thank you!

							Thanx, Paul

> ---
>  kernel/rcu/update.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 6c4b862f57d6..24fb64fd1a1a 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -98,15 +98,15 @@ module_param(rcu_normal_after_boot, int, 0);
>  static bool rcu_read_lock_held_common(bool *ret)
>  {
>  	if (!debug_lockdep_rcu_enabled()) {
> -		*ret = 1;
> +		*ret = true;
>  		return true;
>  	}
>  	if (!rcu_is_watching()) {
> -		*ret = 0;
> +		*ret = false;
>  		return true;
>  	}
>  	if (!rcu_lockdep_current_cpu_online()) {
> -		*ret = 0;
> +		*ret = false;
>  		return true;
>  	}
>  	return false;
> -- 
> 2.25.1
> 
