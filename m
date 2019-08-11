Return-Path: <SRS0=Ms3y=WH=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73982C0650F
	for <rcu@archiver.kernel.org>; Sun, 11 Aug 2019 18:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DDC208C2
	for <rcu@archiver.kernel.org>; Sun, 11 Aug 2019 18:08:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TPV0Djid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfHKSIz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 11 Aug 2019 14:08:55 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:40300 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfHKSIz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 11 Aug 2019 14:08:55 -0400
Received: by mail-pl1-f174.google.com with SMTP id a93so46950561pla.7
        for <rcu@vger.kernel.org>; Sun, 11 Aug 2019 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=yoil/RKMpuTQtV0AuHtgcT4DJJJTGHvWfHVxacKKIPQ=;
        b=TPV0DjidjA+QPcpAzhWnSfI1imS442Shi6ALfnTxcwjuqPw4QFwHFPpkxndlYyT9Pv
         WpeP0YUxfyKdd8PaIyqJaZ323XpdqLUdrqKy3XMf0ofy8p+TUu5ltzEN6EVkx8D6QiS7
         cPw4+KlrDYD+X9EliOTzUPvzemBe88Zq/42b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=yoil/RKMpuTQtV0AuHtgcT4DJJJTGHvWfHVxacKKIPQ=;
        b=ageYUIA2PrV8SmQnr6vWgv6tbpf+5g5MhIg1CgqZFQCvhAGPRMJobC0cKRf0KHcPY8
         RSIVy7rDZhjLxdb4selP8vBtUigpBaUwRe78S22sHbBHAG5DOLiKdjM/hKtx49bVbG3e
         atganDpzeT/YcfDhTKJEUO8EfAdhN6LrQ/0MkpFnuk/WxGPmfCbRegxM+jCKAVpkEPPT
         ek502D4hQ41slTqhbMJSy9CMBPjFWNdL3WU3C04+DD6gHS3FRt2+hb9FdwRXbtwprGIk
         uUMNLhNjL1H1wW4S9JFazwlJKKaKEhDlM1wJ0fl8iyivaF/5GpVbrXqP4ipPAFWmVR9E
         Af7w==
X-Gm-Message-State: APjAAAW9+IRbyw16zzk8kBNVbLbvu1PFn9Zk0dv8UIwVVkWlK50CWh+S
        HsDB+K6SokwsDwG7ysKNjpsEN0dGsHU=
X-Google-Smtp-Source: APXvYqzMElb3bWQTvP7jQzpA8oHcGPdNHZvOMri2/9ydad0U+S+elnvIdgtZ//KqrpIY8iVWDlkL1A==
X-Received: by 2002:a17:902:aa09:: with SMTP id be9mr28512655plb.52.1565546934488;
        Sun, 11 Aug 2019 11:08:54 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x24sm100126430pgl.84.2019.08.11.11.08.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 11:08:53 -0700 (PDT)
Date:   Sun, 11 Aug 2019 14:08:52 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     rcu@vger.kernel.org, paulmck@linux.ibm.com
Subject: need_heavy_qs flag for PREEMPT=y kernels
Message-ID: <20190811180852.GA128944@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Paul, everyone,

I noticed on reading code that the need_heavy_qs check and
rcu_momentary_dyntick_idle() is only called for !PREEMPT kernels. Don't we
need to call this for PREEMPT kernels for the benefit of nohz_full CPUs?

Consider the following events:
1. Kernel is PREEMPT=y configuration.
2. CPU 2 is a nohz_full CPU running only a single task and the tick is off.
3. CPU 2 is running only in kernel mode and does not enter user mode or idle.
4. Grace period thread running on CPU 3 enter the fqs loop.
5. Enough time passes and it sets the need_heavy_qs for CPU2.
6. CPU 2 is still in kernel mode but does cond_resched().
7. cond_resched() does not call rcu_momentary_dyntick_idle() because PREEMPT=y.

Is 7. not calling rcu_momentary_dyntick_idle() a lost opportunity for the FQS
loop to detect that the CPU has crossed a quiescent point?

Is this done so that cond_resched() is fast for PREEMPT=y kernels?

thanks,

 - Joel


