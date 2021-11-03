Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F6BC433EF
	for <rcu@archiver.kernel.org>; Wed,  3 Nov 2021 18:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AE7260D43
	for <rcu@archiver.kernel.org>; Wed,  3 Nov 2021 18:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbhKCSKT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 3 Nov 2021 14:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhKCSKS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 3 Nov 2021 14:10:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A1D360EDF;
        Wed,  3 Nov 2021 18:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635962862;
        bh=a1lF8LeitmXA3wHEdxdwXtuc4UHsZnOwTOEeb/6WAh0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ndY7qTJ9YEflzNu0sVHsSPsP5jj1YQj8HoasTBpnXp8dJNs+KP2L0LErw2VGmYGls
         Ts5tqXteMAzcZ+VsXBTCVN4VgQbY17HdarNDTGEKH2ZPIGTNfSdP8FaHl0HaY6WYDc
         h1lII3zYARN13lClI/tKFMcVhS2RkV5aPVbe1DGnfI/8ltz3qMuqEX7++9zdUDi4SB
         ITp3wkxWwFP9W266oHUMA89VZo54IpMPuDwldF10xVJpDkiBDnXKJlNR5qWl9Bvh60
         uAd85EKWH/Lg7FWwhb+eS5rlPOZvA9u0fo4UtYhpOPR6unH3gPgyyd7sm96sUqY57F
         7QBaxmwy2Vkjg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E94855C0848; Wed,  3 Nov 2021 11:07:41 -0700 (PDT)
Date:   Wed, 3 Nov 2021 11:07:41 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rcu] docs: RCU: Avoid 'Symbol' font-family in SVG figures
Message-ID: <20211103180741.GS880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <c363a4b2-143c-c334-4c5b-2f16acbf3989@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c363a4b2-143c-c334-4c5b-2f16acbf3989@gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Nov 03, 2021 at 08:48:15AM +0900, Akira Yokosawa wrote:
> Subject: [PATCH -rcu] docs: RCU: Avoid 'Symbol' font-family in SVG figures
> 
> On Ubuntu Focal, strings in some of SVG files under
> Documentation/RCU/Design can not be rendered properly when
> converted to PDF.
> 
> Ubuntu releases since Focal and Debian bullseye have trouble
> with "Symbol" font-family in SVG files.
> 
> As those strings are mostly API names such as "READ_ONCE()",
> "WRITE_ONCE(), "rcu_read_lock()", and so on, using a generic
> monospace font-family should be a good alternative.
> 
> Substitute the font-family name by a simple sed pattern:
> 
>     's/Symbol/monospace/g'
> 
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> ---
> Hi Paul,
> 
> As was discussed off-list messages, here is a workaround
> to avoid illegible strings in RCU.pdf when built on
> Ubuntu Focal.
> 
> It turns out Debian bullseye also shows the same symptom.
> Recent Ubuntu releases of Hirsute and Impish do too.
> 
> My suggestion was to substitute "Mono" for "Symbol", but
> "monospace" is used as a generic font-family in recent
> versions of Inkscape.
> 
> This is relative to -rcu's dev branch.

Queued for review and testing, and thank you very much!

							Thanx, Paul

>         Thanks, Akira
> --
>  .../Expedited-Grace-Periods/Funnel0.svg       |  4 +-
>  .../Expedited-Grace-Periods/Funnel1.svg       |  4 +-
>  .../Expedited-Grace-Periods/Funnel2.svg       |  4 +-
>  .../Expedited-Grace-Periods/Funnel3.svg       |  4 +-
>  .../Expedited-Grace-Periods/Funnel4.svg       |  4 +-
>  .../Expedited-Grace-Periods/Funnel5.svg       |  4 +-
>  .../Expedited-Grace-Periods/Funnel6.svg       |  4 +-
>  .../Expedited-Grace-Periods/Funnel7.svg       |  4 +-
>  .../Expedited-Grace-Periods/Funnel8.svg       |  4 +-
>  .../Requirements/GPpartitionReaders1.svg      | 36 +++++------
>  .../Requirements/ReadersPartitionGP1.svg      | 62 +++++++++----------
>  11 files changed, 67 insertions(+), 67 deletions(-)
> 
> diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel0.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel0.svg
> index 98af66557908..16b1ff0ad38c 100644
> --- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel0.svg
> +++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel0.svg
> @@ -116,7 +116,7 @@
>      <flowRoot
>         xml:space="preserve"
>         id="flowRoot2985"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
>           id="flowRegion2987"><rect
>             id="rect2989"
>             width="82.85714"
> @@ -125,7 +125,7 @@
>             y="492.36218" /></flowRegion><flowPara
>           id="flowPara2991" /></flowRoot>    <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="362.371"
>         y="262.51819"
>         id="text4441"
> diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel1.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel1.svg
> index e0184a37aec7..684a4b969725 100644
> --- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel1.svg
> +++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel1.svg
> @@ -116,7 +116,7 @@
>      <flowRoot
>         xml:space="preserve"
>         id="flowRoot2985"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
>           id="flowRegion2987"><rect
>             id="rect2989"
>             width="82.85714"
> @@ -125,7 +125,7 @@
>             y="492.36218" /></flowRegion><flowPara
>           id="flowPara2991" /></flowRoot>    <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="362.371"
>         y="262.51819"
>         id="text4441"
> diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel2.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel2.svg
> index 1bc3fed54d58..8fb2454d9544 100644
> --- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel2.svg
> +++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel2.svg
> @@ -116,7 +116,7 @@
>      <flowRoot
>         xml:space="preserve"
>         id="flowRoot2985"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
>           id="flowRegion2987"><rect
>             id="rect2989"
>             width="82.85714"
> @@ -125,7 +125,7 @@
>             y="492.36218" /></flowRegion><flowPara
>           id="flowPara2991" /></flowRoot>    <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="362.371"
>         y="262.51819"
>         id="text4441"
> diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel3.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel3.svg
> index 6d8a1bffb3e4..5d4f22d5662c 100644
> --- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel3.svg
> +++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel3.svg
> @@ -116,7 +116,7 @@
>      <flowRoot
>         xml:space="preserve"
>         id="flowRoot2985"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
>           id="flowRegion2987"><rect
>             id="rect2989"
>             width="82.85714"
> @@ -125,7 +125,7 @@
>             y="492.36218" /></flowRegion><flowPara
>           id="flowPara2991" /></flowRoot>    <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="362.371"
>         y="262.51819"
>         id="text4441"
> diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel4.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel4.svg
> index 44018fd6342b..b89b02869914 100644
> --- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel4.svg
> +++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel4.svg
> @@ -116,7 +116,7 @@
>      <flowRoot
>         xml:space="preserve"
>         id="flowRoot2985"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
>           id="flowRegion2987"><rect
>             id="rect2989"
>             width="82.85714"
> @@ -125,7 +125,7 @@
>             y="492.36218" /></flowRegion><flowPara
>           id="flowPara2991" /></flowRoot>    <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="362.371"
>         y="262.51819"
>         id="text4441"
> diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel5.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel5.svg
> index e5eef50454fb..90f1c77bea2f 100644
> --- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel5.svg
> +++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel5.svg
> @@ -116,7 +116,7 @@
>      <flowRoot
>         xml:space="preserve"
>         id="flowRoot2985"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
>           id="flowRegion2987"><rect
>             id="rect2989"
>             width="82.85714"
> @@ -125,7 +125,7 @@
>             y="492.36218" /></flowRegion><flowPara
>           id="flowPara2991" /></flowRoot>    <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="362.371"
>         y="262.51819"
>         id="text4441"
> diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel6.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel6.svg
> index fbd2c1892886..3e5651da031a 100644
> --- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel6.svg
> +++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel6.svg
> @@ -116,7 +116,7 @@
>      <flowRoot
>         xml:space="preserve"
>         id="flowRoot2985"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
>           id="flowRegion2987"><rect
>             id="rect2989"
>             width="82.85714"
> @@ -125,7 +125,7 @@
>             y="492.36218" /></flowRegion><flowPara
>           id="flowPara2991" /></flowRoot>    <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="362.371"
>         y="262.51819"
>         id="text4441"
> diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel7.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel7.svg
> index 502e159ed278..9483f08d345e 100644
> --- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel7.svg
> +++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel7.svg
> @@ -116,7 +116,7 @@
>      <flowRoot
>         xml:space="preserve"
>         id="flowRoot2985"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
>           id="flowRegion2987"><rect
>             id="rect2989"
>             width="82.85714"
> @@ -125,7 +125,7 @@
>             y="492.36218" /></flowRegion><flowPara
>           id="flowPara2991" /></flowRoot>    <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="362.371"
>         y="262.51819"
>         id="text4441"
> diff --git a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel8.svg b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel8.svg
> index 677401551c7d..1101ec30e604 100644
> --- a/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel8.svg
> +++ b/Documentation/RCU/Design/Expedited-Grace-Periods/Funnel8.svg
> @@ -116,7 +116,7 @@
>      <flowRoot
>         xml:space="preserve"
>         id="flowRoot2985"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
>           id="flowRegion2987"><rect
>             id="rect2989"
>             width="82.85714"
> @@ -125,7 +125,7 @@
>             y="492.36218" /></flowRegion><flowPara
>           id="flowPara2991" /></flowRoot>    <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="362.371"
>         y="262.51819"
>         id="text4441"
> diff --git a/Documentation/RCU/Design/Requirements/GPpartitionReaders1.svg b/Documentation/RCU/Design/Requirements/GPpartitionReaders1.svg
> index 4b4014fda770..87851a8fac1e 100644
> --- a/Documentation/RCU/Design/Requirements/GPpartitionReaders1.svg
> +++ b/Documentation/RCU/Design/Requirements/GPpartitionReaders1.svg
> @@ -88,7 +88,7 @@
>      <flowRoot
>         xml:space="preserve"
>         id="flowRoot2985"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
>           id="flowRegion2987"><rect
>             id="rect2989"
>             width="82.85714"
> @@ -103,7 +103,7 @@
>           id="text2993"
>           y="-261.66608"
>           x="412.12299"
> -         style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +         style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>           xml:space="preserve"
>           transform="matrix(0,1,-1,0,0,0)"><tspan
>             y="-261.66608"
> @@ -135,7 +135,7 @@
>      </g>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="112.04738"
>         y="268.18076"
>         id="text4429"
> @@ -146,7 +146,7 @@
>           y="268.18076">WRITE_ONCE(a, 1);</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="112.04738"
>         y="439.13766"
>         id="text4441"
> @@ -157,7 +157,7 @@
>           y="439.13766">WRITE_ONCE(b, 1);</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="255.60869"
>         y="309.29346"
>         id="text4445"
> @@ -168,7 +168,7 @@
>           y="309.29346">r1 = READ_ONCE(a);</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="255.14423"
>         y="520.61786"
>         id="text4449"
> @@ -179,7 +179,7 @@
>           y="520.61786">WRITE_ONCE(c, 1);</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="396.10254"
>         y="384.71124"
>         id="text4453"
> @@ -190,7 +190,7 @@
>           y="384.71124">r2 = READ_ONCE(b);</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="396.10254"
>         y="582.13617"
>         id="text4457"
> @@ -201,7 +201,7 @@
>           y="582.13617">r3 = READ_ONCE(c);</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="112.08231"
>         y="213.91006"
>         id="text4461"
> @@ -212,7 +212,7 @@
>           y="213.91006">thread0()</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="252.34512"
>         y="213.91006"
>         id="text4461-6"
> @@ -223,7 +223,7 @@
>           y="213.91006">thread1()</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="396.42557"
>         y="213.91006"
>         id="text4461-2"
> @@ -251,7 +251,7 @@
>         inkscape:connector-curvature="0" />
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="111.75929"
>         y="251.53981"
>         id="text4429-8"
> @@ -262,7 +262,7 @@
>           y="251.53981">rcu_read_lock();</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="396.10254"
>         y="367.91556"
>         id="text4429-8-9"
> @@ -273,7 +273,7 @@
>           y="367.91556">rcu_read_lock();</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="396.10254"
>         y="597.40289"
>         id="text4429-8-9-3"
> @@ -284,7 +284,7 @@
>           y="597.40289">rcu_read_unlock();</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="111.75929"
>         y="453.15311"
>         id="text4429-8-9-3-1"
> @@ -300,7 +300,7 @@
>         inkscape:connector-curvature="0" />
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="394.94427"
>         y="345.66351"
>         id="text4648"
> @@ -324,7 +324,7 @@
>         sodipodi:open="true" />
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="112.11968"
>         y="475.77856"
>         id="text4648-4"
> @@ -361,7 +361,7 @@
>         sodipodi:open="true" />
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="254.85066"
>         y="348.96619"
>         id="text4648-4-3"
> diff --git a/Documentation/RCU/Design/Requirements/ReadersPartitionGP1.svg b/Documentation/RCU/Design/Requirements/ReadersPartitionGP1.svg
> index 48cd1623d4d4..e2a8af592bab 100644
> --- a/Documentation/RCU/Design/Requirements/ReadersPartitionGP1.svg
> +++ b/Documentation/RCU/Design/Requirements/ReadersPartitionGP1.svg
> @@ -116,7 +116,7 @@
>      <flowRoot
>         xml:space="preserve"
>         id="flowRoot2985"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"><flowRegion
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"><flowRegion
>           id="flowRegion2987"><rect
>             id="rect2989"
>             width="82.85714"
> @@ -131,7 +131,7 @@
>           id="text2993"
>           y="-261.66608"
>           x="436.12299"
> -         style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +         style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>           xml:space="preserve"
>           transform="matrix(0,1,-1,0,0,0)"><tspan
>             y="-261.66608"
> @@ -163,7 +163,7 @@
>      </g>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="112.04738"
>         y="268.18076"
>         id="text4429"
> @@ -174,7 +174,7 @@
>           y="268.18076">WRITE_ONCE(a, 1);</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="112.04738"
>         y="487.13766"
>         id="text4441"
> @@ -185,7 +185,7 @@
>           y="487.13766">WRITE_ONCE(b, 1);</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="255.60869"
>         y="297.29346"
>         id="text4445"
> @@ -196,7 +196,7 @@
>           y="297.29346">r1 = READ_ONCE(a);</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="255.14423"
>         y="554.61786"
>         id="text4449"
> @@ -207,7 +207,7 @@
>           y="554.61786">WRITE_ONCE(c, 1);</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="396.10254"
>         y="370.71124"
>         id="text4453"
> @@ -218,7 +218,7 @@
>           y="370.71124">WRITE_ONCE(d, 1);</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="396.10254"
>         y="572.13617"
>         id="text4457"
> @@ -229,7 +229,7 @@
>           y="572.13617">r2 = READ_ONCE(c);</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="112.08231"
>         y="213.91006"
>         id="text4461"
> @@ -240,7 +240,7 @@
>           y="213.91006">thread0()</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="252.34512"
>         y="213.91006"
>         id="text4461-6"
> @@ -251,7 +251,7 @@
>           y="213.91006">thread1()</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="396.42557"
>         y="213.91006"
>         id="text4461-2"
> @@ -281,7 +281,7 @@
>         sodipodi:nodetypes="cc" />
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="111.75929"
>         y="251.53981"
>         id="text4429-8"
> @@ -292,7 +292,7 @@
>           y="251.53981">rcu_read_lock();</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="396.10254"
>         y="353.91556"
>         id="text4429-8-9"
> @@ -303,7 +303,7 @@
>           y="353.91556">rcu_read_lock();</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="396.10254"
>         y="587.40289"
>         id="text4429-8-9-3"
> @@ -314,7 +314,7 @@
>           y="587.40289">rcu_read_unlock();</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="111.75929"
>         y="501.15311"
>         id="text4429-8-9-3-1"
> @@ -331,7 +331,7 @@
>         sodipodi:nodetypes="cc" />
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="394.94427"
>         y="331.66351"
>         id="text4648"
> @@ -355,7 +355,7 @@
>         sodipodi:open="true" />
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="112.11968"
>         y="523.77856"
>         id="text4648-4"
> @@ -392,7 +392,7 @@
>         sodipodi:open="true" />
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="254.85066"
>         y="336.96619"
>         id="text4648-4-3"
> @@ -421,7 +421,7 @@
>           id="text2993-7"
>           y="-261.66608"
>           x="440.12299"
> -         style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +         style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>           xml:space="preserve"
>           transform="matrix(0,1,-1,0,0,0)"><tspan
>             y="-261.66608"
> @@ -453,7 +453,7 @@
>      </g>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="541.70508"
>         y="387.6217"
>         id="text4445-0"
> @@ -464,7 +464,7 @@
>           y="387.6217">r3 = READ_ONCE(d);</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="541.2406"
>         y="646.94611"
>         id="text4449-6"
> @@ -488,7 +488,7 @@
>         sodipodi:open="true" />
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="540.94702"
>         y="427.29443"
>         id="text4648-4-3-1"
> @@ -499,7 +499,7 @@
>           y="427.29443">QS</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="686.27747"
>         y="461.83929"
>         id="text4453-7"
> @@ -510,7 +510,7 @@
>           y="461.83929">r4 = READ_ONCE(b);</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="686.27747"
>         y="669.26422"
>         id="text4457-9"
> @@ -521,7 +521,7 @@
>           y="669.26422">r5 = READ_ONCE(e);</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="686.27747"
>         y="445.04358"
>         id="text4429-8-9-33"
> @@ -532,7 +532,7 @@
>           y="445.04358">rcu_read_lock();</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="686.27747"
>         y="684.53094"
>         id="text4429-8-9-3-8"
> @@ -543,7 +543,7 @@
>           y="684.53094">rcu_read_unlock();</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="685.11914"
>         y="422.79153"
>         id="text4648-9"
> @@ -567,7 +567,7 @@
>         sodipodi:open="true" />
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="397.85934"
>         y="609.59003"
>         id="text4648-5"
> @@ -591,7 +591,7 @@
>         sodipodi:open="true" />
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="256.75986"
>         y="586.99133"
>         id="text4648-5-2"
> @@ -615,7 +615,7 @@
>         sodipodi:open="true" />
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="546.22791"
>         y="213.91006"
>         id="text4461-2-5"
> @@ -626,7 +626,7 @@
>           y="213.91006">thread3()</tspan></text>
>      <text
>         xml:space="preserve"
> -       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:Symbol;-inkscape-font-specification:Symbol"
> +       style="font-size:10px;font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;text-align:center;line-height:125%;letter-spacing:0px;word-spacing:0px;writing-mode:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-family:monospace;-inkscape-font-specification:monospace"
>         x="684.00067"
>         y="213.91006"
>         id="text4461-2-1"
> 
> base-commit: 2fef638a161f05fe94df7c8f7b52721131a83cde
> -- 
> 2.17.1
> 
