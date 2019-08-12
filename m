Return-Path: <SRS0=P5Uu=WI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931A1C31E40
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 05:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B432087B
	for <rcu@archiver.kernel.org>; Mon, 12 Aug 2019 05:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565586180;
	bh=dkXz6e/E5uuKCjklSsio9Wi/z0A/ofiJ0WK3lYOv9I0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GOvaczGrWS8vc+H8iYkKq5urXXB4Akl+4qvKbj1Oc/IlzneQlh4QiCL+JYZ5LZ0W7
	 QMniLPFZSduOWM6SqKKRsiKEWX0YJiaxIe/+J8APk/sJ7EvtxCJqQvTEXAk+90CZiP
	 M7UjH3c+e3hGGzbyG9pqGpq7WdfiSdv/ACp/2RyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbfHLFDA (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 12 Aug 2019 01:03:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfHLFDA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 12 Aug 2019 01:03:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49A7320842;
        Mon, 12 Aug 2019 05:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565586178;
        bh=dkXz6e/E5uuKCjklSsio9Wi/z0A/ofiJ0WK3lYOv9I0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fT8rKH3ZfEKa3aaCJ3w/qjJiTZogdSB366BUTlCy64cqkbHQjl/vPdnjNhGwe2rwq
         Of+b8YNEsxtk4PrxSPLAjYq78YQY/NCTMajihlv/b0Es50X/F+xy/V951fFSFDauQy
         jrIxTuXD6NzDJOHkwIOpOBm/SB28M2sirMimZZ+Y=
Date:   Mon, 12 Aug 2019 07:02:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 3/3] driver/core: Fix build error when SRCU and lockdep
 disabled
Message-ID: <20190812050256.GC5834@kroah.com>
References: <20190811221111.99401-1-joel@joelfernandes.org>
 <20190811221111.99401-3-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811221111.99401-3-joel@joelfernandes.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sun, Aug 11, 2019 at 06:11:11PM -0400, Joel Fernandes (Google) wrote:
> Properly check if lockdep lock checking is disabled at config time. If
> so, then lock_is_held() is undefined so don't do any checking.
> 
> This fix is similar to the pattern used in srcu_read_lock_held().
> 
> Link: https://lore.kernel.org/lkml/201908080026.WSAFx14k%25lkp@intel.com/
> Fixes: c9e4d3a2fee8 ("acpi: Use built-in RCU list checking for acpi_ioremaps list")

What tree is this commit in?

> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
> This patch is based on the -rcu dev branch.

Ah...

>  drivers/base/core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 32cf83d1c744..fe25cf690562 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -99,7 +99,11 @@ void device_links_read_unlock(int not_used)
>  
>  int device_links_read_lock_held(void)
>  {
> -	return lock_is_held(&device_links_lock);
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	return lock_is_held(&(device_links_lock.dep_map));
> +#else
> +	return 1;
> +#endif

return 1?  So the lock is always held?

confused,

greg k-h
