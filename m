Return-Path: <SRS0=zrtj=4W=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E067C3F2D1
	for <rcu@archiver.kernel.org>; Thu,  5 Mar 2020 23:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D832073D
	for <rcu@archiver.kernel.org>; Thu,  5 Mar 2020 23:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583449625;
	bh=gQZUrCpCzK5I7nOgSMbhnWwrmivYI6b29O+E1TrAM0s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=GSRW35pRaO7S0KRanYDXQz/gFqIPepZhQDUxPQNdexe1ubsz2kXwaIVJIpQXsEZCp
	 uTqOFuex7vO5FQca4ob7A5JNW4vG65K5RC0jaElR1YXVJBk6kZnISr9Qom0WFobd7r
	 Jv7UAcL7/IS/9K9dTFUBDD94DbQ0AlHNUxyteow0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCEXHF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Mar 2020 18:07:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:60378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgCEXHF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Mar 2020 18:07:05 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B578320716;
        Thu,  5 Mar 2020 23:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583449624;
        bh=gQZUrCpCzK5I7nOgSMbhnWwrmivYI6b29O+E1TrAM0s=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YFphNM6kKp1X+9Fvlt1FwaPz4jKVMH/GJXsnRp+kNjVnSrS9RUsRspKrKlII1Uo8n
         x2HIR419UqKp6OHaYaZ1fkxfEjwYwBrua3XuagisXzx4W8TMgyf4vm2iYKtwSYqPTb
         joQfb9mrk/6vd0hWmYb1Zw+ianI9mW6lt1hDXzeg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7EF653522806; Thu,  5 Mar 2020 15:07:04 -0800 (PST)
Date:   Thu, 5 Mar 2020 15:07:04 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     rcu@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "rculist: Describe variadic macro argument in a
 Sphinx-compatible way"
Message-ID: <20200305230704.GO2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200305222255.25266-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200305222255.25266-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 05, 2020 at 11:22:55PM +0100, Jonathan Neuschäfer wrote:
> This reverts commit f452ee096d95482892b101bde4fd037fa025d3cc.
> 
> The workaround became unnecessary with commit 43756e347f21
> ("scripts/kernel-doc: Add support for named variable macro arguments").
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Good to hear!

Applied, thank you!

							Thanx, Paul

> ---
>  include/linux/rculist.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index 9f313e4999fe..93accccb9620 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -371,7 +371,7 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
>   * @pos:	the type * to use as a loop cursor.
>   * @head:	the head for your list.
>   * @member:	the name of the list_head within the struct.
> - * @cond...:	optional lockdep expression if called from non-RCU protection.
> + * @cond:	optional lockdep expression if called from non-RCU protection.
>   *
>   * This list-traversal primitive may safely run concurrently with
>   * the _rcu list-mutation primitives such as list_add_rcu()
> @@ -646,7 +646,7 @@ static inline void hlist_add_behind_rcu(struct hlist_node *n,
>   * @pos:	the type * to use as a loop cursor.
>   * @head:	the head for your list.
>   * @member:	the name of the hlist_node within the struct.
> - * @cond...:	optional lockdep expression if called from non-RCU protection.
> + * @cond:	optional lockdep expression if called from non-RCU protection.
>   *
>   * This list-traversal primitive may safely run concurrently with
>   * the _rcu list-mutation primitives such as hlist_add_head_rcu()
> --
> 2.20.1
> 
