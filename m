Return-Path: <SRS0=6i3J=EJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BFDC388F7
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 04:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E71FC22245
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 04:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604376849;
	bh=A0shc1fhXsV5XG5c2jf/T0jNqwy0w6oicaRw4E64ZsE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=Vg54ttBPYnUbeh1ixcF4PXTRgsyuA7UmJgMJeajOzj0sZA5ugGI9hG3lbc6ZP0czH
	 /JzecsbgUPBTHP5FbRaNRIePMk9a8rhBT1L5Mypclcpr3azZFN92A0MVmVayvjPhGV
	 hscffSiTOSKl5cZeSSnBe7Htp2Eu4OCnPl9thmQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKCEOI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 2 Nov 2020 23:14:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgKCEOI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 2 Nov 2020 23:14:08 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E1902224E;
        Tue,  3 Nov 2020 04:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604376848;
        bh=A0shc1fhXsV5XG5c2jf/T0jNqwy0w6oicaRw4E64ZsE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BIMFPU8r6lRwAvFHggFVIyOtxsBjM3yo+Guy4ru/v+AiuNLhTzihBWvTgYG7TIs+1
         NTd5wh05qwhL/2MgRRsrPmQOVzatE12dmlDNEuYghu56Ic2SA1ZX3dr4FYb+TZgid7
         uOi3G2O1MJsvpKOm0Ejk3hFYbDDsvgRu4/1TBBtY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E33323522B94; Mon,  2 Nov 2020 20:14:07 -0800 (PST)
Date:   Mon, 2 Nov 2020 20:14:07 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     RCU <rcu@vger.kernel.org>,
        Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH] tools/rcutorture: Fix BUG parsing of console.log
Message-ID: <20201103041407.GZ3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201102171220.8820-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102171220.8820-1-anna-maria@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Nov 02, 2020 at 06:12:20PM +0100, Anna-Maria Behnsen wrote:
> For the rcutorture test summary log file console.log of virtual machines is
> parsed. When a console.log contains "DEBUG", BUG counter is incremented
> because regular expression does not handle to ignore DEBUG.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Reviewed-by: Benedikt Spranger <b.spranger@linutronix.de>

Good catch, queued for testing and review, thank you!

							Thanx, Paul

> ---
>  tools/testing/selftests/rcutorture/bin/parse-console.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
> index e03338091a06..263b1be50008 100755
> --- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
> +++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
> @@ -133,7 +133,7 @@ then
>  	then
>  		summary="$summary  Warnings: $n_warn"
>  	fi
> -	n_bugs=`egrep -c 'BUG|Oops:' $file`
> +	n_bugs=`egrep -c '\bBUG|Oops:' $file`
>  	if test "$n_bugs" -ne 0
>  	then
>  		summary="$summary  Bugs: $n_bugs"
> -- 
> 2.20.1
> 
