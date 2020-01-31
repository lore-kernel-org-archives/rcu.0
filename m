Return-Path: <SRS0=c3Ty=3U=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A806C2D0DB
	for <rcu@archiver.kernel.org>; Fri, 31 Jan 2020 00:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2595A20663
	for <rcu@archiver.kernel.org>; Fri, 31 Jan 2020 00:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLEfgcam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbgAaA76 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 30 Jan 2020 19:59:58 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37271 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbgAaA76 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 30 Jan 2020 19:59:58 -0500
Received: by mail-qk1-f196.google.com with SMTP id 21so4995871qky.4;
        Thu, 30 Jan 2020 16:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=amgyOvyccdHIcAj+pKAqgwZJU1n1bhRqiRwNFrM8HAw=;
        b=jLEfgcamsEsjkkxuwqIotuAyzqAcbZjFjCkWAjlCv0yb/xgllO9BiBQt+2x5VUDm2r
         BIMB+AZwM0GVWTW8nTqKvD2OgKNBuRtVMZq3jQllJnnpzHzki/XMP25sCMiWc90rUioY
         k8EZqmE1yFqd8Lx6TdT1lMx2TWoH+iUKl6dQNkn9ZRilAFg+CTV8PrOs64LuHCL3xKlE
         e2gIiyTqc7gOihRPM2Uv9yPD7YJevbRetSa0cdyBaNb2HfWQTDKCIcrORv7G17pji6EJ
         5IwJl6uOgm5BtzjG+jVOkAkE+XW8rlsKDCjJ9zE6gFo0eSwprU67cMgc9lgXhbavPRPe
         8qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=amgyOvyccdHIcAj+pKAqgwZJU1n1bhRqiRwNFrM8HAw=;
        b=aeF1S+Jj/poxFS/fXs2cR99nH8gxgvImMy09r3Re6i7P+6QehD7hYkcT8Z4rawnX3K
         f1zqDV0gb8X1bWv9EQ6JOHuXbpNQeNYz6OhBmm5R/PDtBuOMi8lHCFtUn7W3TGbwtlDD
         EwdRqk0GzpK5aP6iopxetAB6W5OC8hGDgas9Qg1ToXD1EwHkkyjxCW7GGTYY+9lLGuAg
         aj8+K0rhpKqpYU1yKLwb/2vCzBqKV+G0ccGMWNMEBkIExVTj00twzayLGg8ML6YSTpkb
         jxqn1jZSI8CPj7DI/K7E/82v1hxt06kgScDXs34eGHyOl2S5rLkF8wsFTrpM/rxTLZbJ
         DKiQ==
X-Gm-Message-State: APjAAAXc8BXfObqNT+4b04rpBpLzJyg8p3yX1FkYjLIfbmO+IclIxPMR
        IU7CVkRf237yExi1AtvUsOmAr3QM
X-Google-Smtp-Source: APXvYqwAyEwN0C2TrGKUI6BtbJ4hqPYrmWNxVYGGE5ftiVj9BbJ1goQOypEdqUsJqGHsh0+86KSVVQ==
X-Received: by 2002:ae9:efc5:: with SMTP id d188mr8541052qkg.178.1580432396107;
        Thu, 30 Jan 2020 16:59:56 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id g21sm3653515qkl.116.2020.01.30.16.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 16:59:55 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 1B0F122460;
        Thu, 30 Jan 2020 19:59:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 30 Jan 2020 19:59:55 -0500
X-ME-Sender: <xms:CnwzXraYGLmFL8SWe0wTFA-kTGIjThALuCcVqwhW7Z2h9kHTT7v35A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfeelgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhm
    rghilhdrtghomheqnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsg
    hoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:CnwzXtqR8rgz8DrAy9lrq78BWI0P2tSjh-37uUeL5NedUNyYoeASjg>
    <xmx:CnwzXnZ5FBhXNlvgRQ3FFCoU8Lgp9L3INgfWIOUQwkhPs9QNPeS23w>
    <xmx:CnwzXtQ2AV1_jOQZDYp5SR2qgnIyQVu1N-wTHeEmYisVsB58b3ChEg>
    <xmx:C3wzXmCmBPWXJlnMGgFKTInuzqicevXJCeqUObibPR8QAzFrpqhiHh1qrlI>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3A047328005A;
        Thu, 30 Jan 2020 19:59:54 -0500 (EST)
Date:   Fri, 31 Jan 2020 08:59:52 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        joel@joelfernandes.org, jiangshanlai@gmail.com,
        mathieu.desnoyers@efficios.com, rostedt@goodmis.org,
        josh@joshtriplett.org, paulmck@kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH 2/2] rcu/nocb: Add missing annotation for
 rcu_nocb_bypass_unlock()
Message-ID: <20200131005952.GD83200@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <0/2>
 <cover.1580337836.git.jbi.octave@gmail.com>
 <59087bdc398a69ac743ee3e5cfa0bd26495881e3.1580337836.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59087bdc398a69ac743ee3e5cfa0bd26495881e3.1580337836.git.jbi.octave@gmail.com>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jan 30, 2020 at 12:30:09AM +0000, Jules Irenge wrote:
> Sparse reports warning at rcu_nocb_bypass_unlock()
> 
> warning: context imbalance in rcu_nocb_bypass_unlock() - unexpected unlock
> 
> The root cause is a missing annotation of rcu_nocb_bypass_unlock()
> which causes the warning.
> 
> Add the missing __releases(&rdp->nocb_bypass_lock) annotation.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Acked-by: Boqun Feng <boqun.feng@gmail.com>

> ---
>  kernel/rcu/tree_plugin.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 9d21cb07d57c..8783d19a58b2 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1553,6 +1553,7 @@ static bool rcu_nocb_bypass_trylock(struct rcu_data *rdp)
>   * Release the specified rcu_data structure's ->nocb_bypass_lock.
>   */
>  static void rcu_nocb_bypass_unlock(struct rcu_data *rdp)
> +	__releases(&rdp->nocb_bypass_lock)
>  {
>  	lockdep_assert_irqs_disabled();
>  	raw_spin_unlock(&rdp->nocb_bypass_lock);
> -- 
> 2.24.1
> 
