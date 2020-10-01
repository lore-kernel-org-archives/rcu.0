Return-Path: <SRS0=4XKx=DI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E215C4727C
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 07:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13DA421531
	for <rcu@archiver.kernel.org>; Thu,  1 Oct 2020 07:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbgJAHRs convert rfc822-to-8bit (ORCPT
        <rfc822;rcu@archiver.kernel.org>); Thu, 1 Oct 2020 03:17:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:40472 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgJAHRs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Oct 2020 03:17:48 -0400
IronPort-SDR: pBZ3PWi8Ckhh88s9F4GMFLITCbZ1vErlAgIyrH9dq9K5dJw29GY5nBIqEeL5zhCBugaE+aqAwo
 BISd/YbJcYNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="142052867"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="142052867"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 00:17:47 -0700
IronPort-SDR: hQAnFbHrggiNVBl/HoBC3opMLY2zRyjfFl5LSVDrrgjsbmHbQtlYBmz0TJCei/TsPZ/MpBtnX7
 msTS//YjxLvA==
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="458010142"
Received: from liammcl-mobl.ger.corp.intel.com (HELO localhost) ([10.252.11.248])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 00:17:40 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200928233102.24265-11-paulmck@kernel.org>
References: <20200928233041.GA23230@paulmck-ThinkPad-P72> <20200928233102.24265-11-paulmck@kernel.org>
To:     paulmck@kernel.org, rcu@vger.kernel.org
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH tip/core/rcu 11/15] drm/i915: Cleanup PREEMPT_COUNT leftovers
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org, mhocko@kernel.org,
        mgorman@techsingularity.net, torvalds@linux-foundation.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        "Paul E . McKenney" <paulmck@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <160153665673.4398.6268028176406103680@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date:   Thu, 01 Oct 2020 10:17:37 +0300
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Quoting paulmck@kernel.org (2020-09-29 02:30:58)
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
> removed. Cleanup the leftovers before doing so.

Change looks fine:

Reviewed-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>

Are you looking for us to merge or merge through another tree?

If us, did the base patch always enabling PREEMPT_COUNT go into 5.9 or is
it heading to 5.10? We can queue this earliest for 5.11 as drm-next closed
for 5.10 at week of -rc5.

Regards, Joonas

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ---
>  drivers/gpu/drm/i915/Kconfig.debug | 1 -
>  drivers/gpu/drm/i915/i915_utils.h  | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/Kconfig.debug b/drivers/gpu/drm/i915/Kconfig.debug
> index 1cb28c2..17d9b00 100644
> --- a/drivers/gpu/drm/i915/Kconfig.debug
> +++ b/drivers/gpu/drm/i915/Kconfig.debug
> @@ -20,7 +20,6 @@ config DRM_I915_DEBUG
>         bool "Enable additional driver debugging"
>         depends on DRM_I915
>         select DEBUG_FS
> -       select PREEMPT_COUNT
>         select I2C_CHARDEV
>         select STACKDEPOT
>         select DRM_DP_AUX_CHARDEV
> diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
> index 5477337..ecfed86 100644
> --- a/drivers/gpu/drm/i915/i915_utils.h
> +++ b/drivers/gpu/drm/i915/i915_utils.h
> @@ -337,8 +337,7 @@ wait_remaining_ms_from_jiffies(unsigned long timestamp_jiffies, int to_wait_ms)
>                                                    (Wmax))
>  #define wait_for(COND, MS)             _wait_for((COND), (MS) * 1000, 10, 1000)
>  
> -/* If CONFIG_PREEMPT_COUNT is disabled, in_atomic() always reports false. */
> -#if defined(CONFIG_DRM_I915_DEBUG) && defined(CONFIG_PREEMPT_COUNT)
> +#ifdef CONFIG_DRM_I915_DEBUG
>  # define _WAIT_FOR_ATOMIC_CHECK(ATOMIC) WARN_ON_ONCE((ATOMIC) && !in_atomic())
>  #else
>  # define _WAIT_FOR_ATOMIC_CHECK(ATOMIC) do { } while (0)
> -- 
> 2.9.5
> 
