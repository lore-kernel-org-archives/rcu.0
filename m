Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C4BC74A5B
	for <rcu@archiver.kernel.org>; Fri, 17 Mar 2023 01:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCQBQD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Mar 2023 21:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCQBQC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Mar 2023 21:16:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8286F2311F
        for <rcu@vger.kernel.org>; Thu, 16 Mar 2023 18:16:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D1BB3CE1EFB
        for <rcu@vger.kernel.org>; Fri, 17 Mar 2023 01:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AB4C433EF;
        Fri, 17 Mar 2023 01:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679015758;
        bh=03n5LfKSS0wVIfzSh9urrT7VAAoPAB4k/XpHJAhT/is=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=DAWPDhSfKCy1qxRnnH64lUvkRvlwTTqSbf8bT6y2tRmbhWFmajdoWEbuBmLCnMxd8
         mxX8DN6iA97JhO6P25JBwHwg8iEDTRyVC5L69XG3a6qklc1c12PnIylq2EZtd1e/9/
         e84sTfplkPaLNQ+sKr6H85IY+93ua6l1VJ9hUoNmsc5k0iBjQl+UCrvJzwWTZHZKlc
         By2yX6HbvEauU3WX74L4XqpeN2rP+5enwQtCVPg0KFqoNr+17WuDTJ2qxJTYZsP9NI
         XK+qidiqj9of8ymLVn0RaNRHNnvePF98FwkcSh4Ti4+PWvHO5fXSHHOItCDpeg3Ol+
         4TjPG2h8fV3Mg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CDDDA1540395; Thu, 16 Mar 2023 18:15:57 -0700 (PDT)
Date:   Thu, 16 Mar 2023 18:15:57 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Adrian Huang <adrianhuang0701@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        Adrian Huang <ahuang12@lenovo.com>
Subject: Re: [PATCH 1/1] docs: RCU: typo fix
Message-ID: <98324e66-69a8-4889-b4d9-290144c21f95@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230316070936.733-1-adrianhuang0701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316070936.733-1-adrianhuang0701@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Mar 16, 2023 at 03:09:36PM +0800, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> It should be "Please note that ..." instead of "Please not that ...".
> 
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>

Good eyes, and thank you,  but Qiuxu Zhuo beat you to this one.
Please see this commit in the -rcu tree's "dev" branch:

3a554688b5c4 ("Documentation/RCU: s/not/note/ in checklist.rst")

						Thanx, Paul

> ---
>  Documentation/RCU/checklist.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
> index cc361fb01ed4..bd3c58c44bef 100644
> --- a/Documentation/RCU/checklist.rst
> +++ b/Documentation/RCU/checklist.rst
> @@ -70,7 +70,7 @@ over a rather long period of time, but improvements are always welcome!
>  	can serve as rcu_read_lock_sched(), but is less readable and
>  	prevents lockdep from detecting locking issues.
>  
> -	Please not that you *cannot* rely on code known to be built
> +	Please note that you *cannot* rely on code known to be built
>  	only in non-preemptible kernels.  Such code can and will break,
>  	especially in kernels built with CONFIG_PREEMPT_COUNT=y.
>  
> -- 
> 2.34.1
> 
