Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B5DC433DB
	for <rcu@archiver.kernel.org>; Thu, 31 Dec 2020 22:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A282620658
	for <rcu@archiver.kernel.org>; Thu, 31 Dec 2020 22:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgLaWqD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 31 Dec 2020 17:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgLaWqD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 31 Dec 2020 17:46:03 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C9CC061573;
        Thu, 31 Dec 2020 14:45:22 -0800 (PST)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 63D3260B;
        Thu, 31 Dec 2020 22:45:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 63D3260B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1609454721; bh=tMnJuIUNfFdc8FRuTCustjnoFzYrW86BK7QzKx5Y8uY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fvvOqr2D52pcHO5U+rmC245H1ANjhQVhPQ8anZ3sJBAePTEwjDa+W/9hNIhZfzKuo
         U0wmvhx02lT7Ujt1wzEOoOrgdXa8ooqrtpPF6OPicXT8h/FtmaASaUnD7TXHGTZEEi
         7wyClBrH+KduCpG0eOzDy1xKoYn0PPVIlOoYroJA4RoqVZPX/mXlj+nJFhfokljBQI
         4vYUBoPX4TMEmA1JFA7ldTGGmg6l4oN4a/0OKDTkYDgWBEEqoh/hk9hzIedT2uFTiA
         0vb/iWkG1OPBhRRPNnSeUmIe7NjRu2w37HUpnSPW2miy2dFq27pl+/V7E6cx8vaZQ+
         1UM8LIztNX5Xw==
Date:   Thu, 31 Dec 2020 15:45:19 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, rcu@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        andrealmeid@collabora.com
Subject: Re: [PATCH v2] docs: Fix reST markup when linking to sections
Message-ID: <20201231154519.25425c3b@lwn.net>
In-Reply-To: <20201228144537.135353-1-nfraprado@protonmail.com>
References: <20201228144537.135353-1-nfraprado@protonmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, 28 Dec 2020 14:46:07 +0000
Nícolas F. R. A. Prado <nfraprado@protonmail.com> wrote:

> During the process of converting the documentation to reST, some links
> were converted using the following wrong syntax (and sometimes using %20
> instead of spaces):
> 
>    `Display text <#section-name-in-html>`__
> 
> This syntax isn't valid according to the docutils' spec [1], but more
> importantly, it is specific to HTML, since it uses '#' to link to an
> HTML anchor.
> 
> The right syntax would instead use a docutils hyperlink reference as the
> embedded URI to point to the section [2], that is:
> 
>    `Display text <Section Name_>`__
> 
> This syntax works in both HTML and PDF.
> 
> The LaTeX toolchain doesn't mind the HTML anchor syntax when generating
> the pdf documentation (make pdfdocs), that is, the build succeeds but
> the links don't work, but that syntax causes errors when trying to build
> using the not-yet-merged rst2pdf:
> 
>    ValueError: format not resolved, probably missing URL scheme or undefined destination target for 'Forcing%20Quiescent%20States'
> 
> So, use the correct syntax in order to have it work in all different
> output formats.

Applied, thanks.

jon
