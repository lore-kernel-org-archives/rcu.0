Return-Path: <SRS0=VCsE=EP=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4404CC2D0A3
	for <rcu@archiver.kernel.org>; Mon,  9 Nov 2020 12:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBAAE206CB
	for <rcu@archiver.kernel.org>; Mon,  9 Nov 2020 12:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aG7OXY6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgKIMYq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 9 Nov 2020 07:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbgKIMYq (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 9 Nov 2020 07:24:46 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16774C0613CF;
        Mon,  9 Nov 2020 04:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QYxyicf4bRI86iURehj4XaxXYk1FhGdBaBCPgnoMbz0=; b=aG7OXY6dnRW0z5JBjN6Cut532/
        4+UQM8br17m+Ex3aHax7H2fB7eNmP6SCboF/Et1yPoktDiqu9+I6TplvLGbXNTDlmRiY63U7cNMwa
        RvseGZS+/Nm+rMfT3cbVtoNDy7HtyLgSDgYpAFGnjgxmFVaWUozY4cykwByXlTlnxRDfpIUlNoaCC
        uNaO8mZ/b5Kv4ae7eSe+WYuLSB6iEC4ZqP8gBnkyzAw12MPBe9yLsOJtX/BI941NMi7KCrXXpyr6y
        eS4lVn/h7mF4qg0diI2YuASbbBSGZ4VOjzpS3SMszhD1XWgUJvX8fnpRHH2QdkXYKRGAJVybtNk6x
        sLSa/xBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc6Dh-00026q-S8; Mon, 09 Nov 2020 12:24:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5915A305C16;
        Mon,  9 Nov 2020 13:24:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1E258203C5334; Mon,  9 Nov 2020 13:24:24 +0100 (CET)
Date:   Mon, 9 Nov 2020 13:24:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, Hui Su <sh_def@163.com>
Subject: Re: [PATCH tip/core/rcu 4/4] docs/rcu: Update the call_rcu() API
Message-ID: <20201109122424.GN2594@hirez.programming.kicks-ass.net>
References: <20201105230444.GA18574@paulmck-ThinkPad-P72>
 <20201105230510.18660-4-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105230510.18660-4-paulmck@kernel.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Nov 05, 2020 at 03:05:10PM -0800, paulmck@kernel.org wrote:
> From: Hui Su <sh_def@163.com>
> 
> This commit updates the documented API of call_rcu() to use the
> rcu_callback_t typedef instead of the open-coded function definition.
> 
> Signed-off-by: Hui Su <sh_def@163.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  Documentation/RCU/whatisRCU.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
> index fb3ff76..1a4723f 100644
> --- a/Documentation/RCU/whatisRCU.rst
> +++ b/Documentation/RCU/whatisRCU.rst
> @@ -497,8 +497,7 @@ long -- there might be other high-priority work to be done.
>  In such cases, one uses call_rcu() rather than synchronize_rcu().
>  The call_rcu() API is as follows::
>  
> -	void call_rcu(struct rcu_head * head,
> -		      void (*func)(struct rcu_head *head));
> +	void call_rcu(struct rcu_head *head, rcu_callback_t func);

Personally I much prefer the old form, because now I have to go look up
rcu_callback_t to figure out wtf kind of signature is actually required.
