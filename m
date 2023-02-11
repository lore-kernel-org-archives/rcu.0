Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCB9C05027
	for <rcu@archiver.kernel.org>; Sat, 11 Feb 2023 00:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjBKAc3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 10 Feb 2023 19:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBKAc2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 10 Feb 2023 19:32:28 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADF019F04
        for <rcu@vger.kernel.org>; Fri, 10 Feb 2023 16:32:25 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id x29so8266634ljq.0
        for <rcu@vger.kernel.org>; Fri, 10 Feb 2023 16:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DLk3N6Go0BGyrEJaF9vC3EBGKIKqnzWEMDRO70teK4M=;
        b=cnBtBG0CW3B/2iQ2B5/D9xY8SBHkZx1vfdgXy1z6TvA1ugBr4M4WiTz9R2fksi0PFO
         MyYpbWlkauMp/ZpJbxXO4FEkuZQahxjrUzKPf2uRrdLf3pfQ7tSSoiyxrsfFrWNKzEf9
         kMz9+JMaxH+qfC3cg0oGhAcMDK4w+LmUTbhlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLk3N6Go0BGyrEJaF9vC3EBGKIKqnzWEMDRO70teK4M=;
        b=2WWWfLclAdfzqXWJw5rvR9LBNagFYapD8xIUMU3Jk3y5v+Fe/pUjZ5UCmdqtB3cJvV
         BBZeVa6fBIIi1+UjUuWXiev+FxfG+o5WtvWkqpj6j4gJ5p7heEQw8aVSZHsgsDlZUw4o
         MySfbmlOnkwnO8DmmyXBLOqyx+70Hu49ASD9ei5Oualymiv9qT6h0M35Ew+6jdlc2jMl
         4GbmaLdNnY0F/av44RzBN0uyK80/cY4hStfIqRwc81TN5kOnUFwd11DZW+XMeXuTBWBw
         UBX6+EEKWNa+fBrXVurIQWhB1OEtPB9pvm4GM0s6DX0SupXrX8DuNL6pNzr+LZH/dGM7
         OAtw==
X-Gm-Message-State: AO0yUKUS6V4/oE7VBbX6PihZ2Q1l0BMOzmpxyyamvUOHUdjO7N22Gp/1
        G3u+fotmwJipg2DhYYDnvw5f4mdZe45aMboyxuVt7g==
X-Google-Smtp-Source: AK7set9D/zU4cDYCyWxNtSbviTpbc/NX1394tyVjqRqUcNBQYTAUNU/eh7TnshobTDBv0iuuy9WJ9Z4u82/RZkkdT0c=
X-Received: by 2002:a2e:2f1e:0:b0:293:25c1:808f with SMTP id
 v30-20020a2e2f1e000000b0029325c1808fmr2060546ljv.154.1676075544135; Fri, 10
 Feb 2023 16:32:24 -0800 (PST)
MIME-Version: 1.0
References: <20230204022051.2737724-1-joel@joelfernandes.org>
In-Reply-To: <20230204022051.2737724-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 10 Feb 2023 19:32:12 -0500
Message-ID: <CAEXW_YQN-AxYV=Buxt7jv9VxHWB-hoSUBjJ3VXDoc945qK=5XQ@mail.gmail.com>
Subject: Re: [PATCH] rcu/tree: Improve comments in rcu_report_qs_rdp()
To:     linux-kernel@vger.kernel.org
Cc:     Qiang Zhang <Qiang1.zhang@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Feb 3, 2023 at 9:21 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> Recent discussion triggered due to a patch linked below, from Qiang,
> shed light on the need to accelerate from QS reporting paths.
>
> Update the comments to capture this piece of knowledge.
>
> Link: https://lore.kernel.org/all/20230118073014.2020743-1-qiang1.zhang@intel.com/
> Cc: Qiang Zhang <Qiang1.zhang@intel.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
> ---
>  kernel/rcu/tree.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 93eb03f8ed99..713eb6ca6902 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1983,7 +1983,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>         } else {
>                 /*
>                  * This GP can't end until cpu checks in, so all of our
> -                * callbacks can be processed during the next GP.
> +                * callbacks can be processed during the next GP. Do
> +                * the acceleration from here otherwise there may be extra
> +                * grace period delays, as any accelerations from rcu_core()
> +                * or note_gp_changes() may happen only after the GP after the
> +                * current one has already started. Further, rcu_core()
> +                * only accelerates if RCU is idle (no GP in progress).
>                  *

And I couldn't help but pass this through ChatGPT:

Before:
This GP can't end until cpu checks in, so all of our callbacks can be
processed during the next GP. Do the acceleration from here otherwise
there may be extra grace period delays, as any accelerations from
rcu_core() or note_gp_changes() may happen only after the GP after the
current one has already started. Further, rcu_core() only accelerates
if RCU is idle (no GP in progress). NOCB kthreads have their own way
to deal with that...

After:
In order to ensure all callbacks are processed efficiently, this grace
period (GP) must not end until the CPU checks in. To avoid unnecessary
grace period delays, it is important to initiate acceleration from the
current location. Any acceleration from the functions "rcu_core()" or
"note_gp_changes()" may only occur after the next GP has already
started. It is important to note that "rcu_core()" will only initiate
acceleration if the RCU system is idle (no GP in progress). NOCB
kthreads, on the other hand, have their own unique method for handling
this situation.

It sounds well written, but maybe a bit factually incorrect.. trying again:

To ensure all callbacks are processed in the next grace period, this
GP must not end until the CPU has checked in. To avoid any additional
grace period delays, it's important to perform the acceleration from
here. If acceleration is performed from rcu_core() or
note_gp_changes(), it may only occur after the next GP has already
started. Additionally, it's important to note that rcu_core() will
only accelerate if RCU is idle and no GP is in progress. The NOCB
kthreads have a separate mechanism for dealing with this issue.

Not bad, but the first sentence is still factually incorrect. Yes, I'm
bored..why do you ask? ;-)

I think except for the first sentence though, it made for a nice
grammatical re-write (give or take Frederic and Qiang's comments ;-)).

 - Joel



>                  * NOCB kthreads have their own way to deal with that...
>                  */
> @@ -1993,6 +1998,12 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
>                         /*
>                          * ...but NOCB kthreads may miss or delay callbacks acceleration
>                          * if in the middle of a (de-)offloading process.
> +                        *
> +                        * Such missed acceleration may cause the callbacks to
> +                        * be stranded until RCU is fully de-offloaded, as
> +                        * acceleration from rcu_core() and note_gp_changes()
> +                        * cannot happen for fully/partially offloaded mode due
> +                        * to ordering dependency between rnp lock and nocb_lock.
>                          */
>                         needacc = true;
>                 }
> --
> 2.39.1.519.gcb327c4b5f-goog
>
