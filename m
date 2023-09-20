Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD00DCE79C2
	for <rcu@archiver.kernel.org>; Wed, 20 Sep 2023 10:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233615AbjITKxS (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 20 Sep 2023 06:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjITKxR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 20 Sep 2023 06:53:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE52B4;
        Wed, 20 Sep 2023 03:53:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1096C433C8;
        Wed, 20 Sep 2023 10:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695207191;
        bh=h/O2jwYeAbLYLKbT6nnj9DrgguDTYSmof+htQUoyQkI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pUYePQQDGNByknxlRLr1DWklXKmeu5hup+NjPPbR4+rkvwNrxHpX9rZDUOyf+BQxe
         U/lMohSRUOiFPThvqtNTd/uJrbUGBshvQ5yuzRklUOskjiXZUU9IONjnHxZV+ZWYRb
         I+5C0jmwoTkzzagb8dULwCCJngZ2AP3UYnaOKGPWY0CEPhMiR+0jnroXVVhn6Bu+8J
         1Du1AUFSkjIGwr1l0hrrF+UgwzxJ64gpdteFiUeKB4xM96NQCdPc975UG48pDHyOX5
         G9z2V8MJOlcXzjQ5XshDkgzVeS/nSbUUEzzhs6SAgTwPanY9IWbb53y9956nXE48S8
         K9jM0E4xz6VGA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B0453CE03D5; Wed, 20 Sep 2023 03:53:08 -0700 (PDT)
Date:   Wed, 20 Sep 2023 03:53:08 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rculist.h: docu: fix wrong function name
Message-ID: <db6bc865-199d-4784-a509-5b0c80c0501c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230919194754.20574-2-pstanner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919194754.20574-2-pstanner@redhat.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 19, 2023 at 09:47:55PM +0200, Philipp Stanner wrote:
> The header contains a comment that details why the functions
> list_empty_rcu() and list_first_entry_rcu() don't exist. It explains
> that they don't exist because standard list_empty() can be used just as
> well, but one can not expect sane results from a subsequent, quote,
> "list_first_entry_rcu()".
> 
> This function (obviously) does not exist. What the comment's author
> actually meant was the standard list-function list_first_entry().
> 
> Change the function name in that comment from list_first_entry_rcu() to
> list_first_entry().
> 
> Additionally, add the parenthesis to list_first_or_null_rcu to be congruent
> with that entire comment's style.
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> Hi!
> I hope this helps.
> I wasn't 100.000000% sure if that's correct, but I thought asking is for
> free 8-)
> 
> Regards,
> P.

Thank you for sending this!  Please see below.

							Thanx, Paul

> ---
>  include/linux/rculist.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index d29740be4833..4837d8892691 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -331,9 +331,9 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
>   * rcu_dereference() is not needed), which means that list_empty() can be
>   * used anywhere you would want to use list_empty_rcu().  Just don't
>   * expect anything useful to happen if you do a subsequent lockless
> - * call to list_first_entry_rcu()!!!
> + * call to list_first_entry()!!!

You are quite correct that the original is incorrect, given that it does
not exist, but a better change would be to list_entry_rcu().  The reason
being that list_first_entry() does not have READ_ONCE(), allowing the
compiler to play all sorts of games (see https://lwn.net/Articles/793253
for some examples).

>   *
> - * See list_first_or_null_rcu for an alternative.
> + * See list_first_or_null_rcu() for an alternative.

Good catch!

Please do feel free to send an update.

							Thanx, Paul

>   */
>  
>  /**
> -- 
> 2.41.0
> 
