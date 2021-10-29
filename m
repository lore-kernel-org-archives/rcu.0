Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282A1C433EF
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 16:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0958661177
	for <rcu@archiver.kernel.org>; Fri, 29 Oct 2021 16:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbhJ2QoN (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 Oct 2021 12:44:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44314 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2QoM (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 Oct 2021 12:44:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 232F521977;
        Fri, 29 Oct 2021 16:41:43 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF23713DA0;
        Fri, 29 Oct 2021 16:41:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id epWpHkQkfGFXaAAAMHmgww
        (envelope-from <dave@stgolabs.net>); Fri, 29 Oct 2021 16:41:40 +0000
Date:   Fri, 29 Oct 2021 09:41:36 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Li Zhijian <zhijianx.li@intel.com>
Cc:     joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, paulmck@kernel.org,
        rostedt@goodmis.org, rcu@vger.kernel.org, philip.li@intel.com,
        lizhijian@cn.fujitsu.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] minor fixes and cleanups in rcuscale and torture
 tests
Message-ID: <20211029164136.iy4ueewdnkkqoeyb@offworld>
References: <20211029094029.22501-1-zhijianx.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20211029094029.22501-1-zhijianx.li@intel.com>
User-Agent: NeoMutt/20201120
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 29 Oct 2021, Li Zhijian wrote:

>- we added '\n' to the macros directly like what torture does, see
>include/linux/torture.h
>- SCFTORTOUT is unused any more, remove it
>- follow up https://lkml.org/lkml/2021/10/24/439, covert all other residuals
>
>
>Li Zhijian (6):
>  refscale: add missing '\n' to flush message out
>  scftorture: add missing '\n' to flush message out
>  scftorture: Remove unused SCFTORTOUT
>  scftorture: always log error message
>  rcuscale: alwaly log error message
>  locktorture,rcutorture,torture: always log error message

No particular objection from me.

Acked-by: Davidlohr Bueso <dbueso@suse.de>
