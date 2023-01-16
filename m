Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0690C46467
	for <rcu@archiver.kernel.org>; Mon, 16 Jan 2023 18:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjAPSlB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Jan 2023 13:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbjAPSk1 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Jan 2023 13:40:27 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835B1222F0
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 10:33:09 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id d9so31112254pll.9
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 10:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YTc6GNly3oXKI3Efn3Ml3fC1lK4k/JboFhP5u7ZeAzI=;
        b=Ow25YtDANinHPEU0QcJeFjWGqjH92ivDrHMBEjCq7LMBUb6gXtK3B3Jk9pVGPGDHcS
         RyIXYiGwD/a8X47u93Mw+6DxIRzpVxenHl3wpXusCRi5prFaOVRJlZbcL92eLDaImg13
         dMsopxmOSKeHoTtTaXOphA6lHuH7mUkyi9gaIHaEFKTQuh//glJSuoHl9kZmOKRRjJsq
         CeBqhkbKy1YHwoL68ERmtpSUdZeszCJu/0+7nz09uNt5N4A+5b16zAt6LLqOrX2AVBG9
         cnUd0U+x2uRy5SRTjy4RYaJiwdsnni5n+Q3lqizIotQKGSOxjQd/2YCl6yBTPEBOXLxs
         WaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTc6GNly3oXKI3Efn3Ml3fC1lK4k/JboFhP5u7ZeAzI=;
        b=0cwWsM0/nDYRkiADP5HSjNpMBaZhRDzdwoFgVGUXeZ1sEDHhajE0enmv2vX8YW2ULj
         Eoz1wt604obK/ty+r+RzMRIqpPp7zN54oz+liufVIMgam+MlOnhTKzNw3BG8NBOeXZIW
         2DsXoCckdxUKzFYClaannpR9+6CZf5NUCwj4MN6iVsrVmBE7cx3xcks7OSMtPc3yvvkr
         UfLts9JSoctbo01DA+iFYCqnxsSCPhYws7Hs9KLhKs3+Izyesm/bN5fh9prYhdGF88zu
         0EbtdHlGEu/su9K5cnyU7WNCpXRX7Hzv+/U/d1KXaRUjvtCwIzRrAQNfcfRmtKGeSGpR
         3Rmw==
X-Gm-Message-State: AFqh2kqJY59FjU8DQfJlfoEzE+Opmu/xICORqJyQOMVZ/ShQ7ObXMDiR
        rfVJdm9403H5/OxdNrDOwf/UDlORq/uYc3295/M=
X-Google-Smtp-Source: AMrXdXsFgNIbKxbB+QERyBKq+ZbtbDlivuCFmzXaMjt6V8SLsOAP4tKjfWhrwj0RYS5ewlnhkd1GjEnD9A+hBVq/GiQ=
X-Received: by 2002:a17:902:9041:b0:194:721e:6118 with SMTP id
 w1-20020a170902904100b00194721e6118mr55069plz.44.1673893989013; Mon, 16 Jan
 2023 10:33:09 -0800 (PST)
MIME-Version: 1.0
References: <CAEXW_YQB1Wm3YhgUP8S9a4drgvDasu3s+zyt3j9Wwpt83W=W=Q@mail.gmail.com>
In-Reply-To: <CAEXW_YQB1Wm3YhgUP8S9a4drgvDasu3s+zyt3j9Wwpt83W=W=Q@mail.gmail.com>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Tue, 17 Jan 2023 02:32:57 +0800
Message-ID: <CAABZP2xnCCfCf5DLQuiTXBVbpEgsoedqxA8JsWBLs4SyLOLuFw@mail.gmail.com>
Subject: Re: arm64 torture test hotplug failures (offlining causes -EBUSY)
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        rcu <rcu@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi Joel

On Tue, Jan 17, 2023 at 1:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> Hello,
> I am seeing -EBUSY returned a lot during torture_onoff() when running
> rcutorture on arm64. This causes hotplug failure 30% of the time. I am
> also seeing this in 6.1-rc kernels. I believe see this only for CPU0.
>
> This causes warnings in torture tests:
> [  217.582290] rcu-torture:torture_onoff task: offline 0 failed: errno -16
> [  221.866362] rcu-torture:torture_onoff task: offline 0 failed: errno -16
>
> Full kernel log here:
> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TREE04/console.log
>
> Any ideas on why this is happening and only for CPU 0 (presumably the
> boot CPU)? I'd personally need these warnings to go away for my tests
> as this causes rcutorture's tests to not cleanly pass for me. It
> appears remove_cpu() -> device_offline() is what returns the error.
>
I guess this probably because CPU 0 is the tick_do_timer_cpu in
nohz_full mode, which prevent that cpu from
going offline [1]. We have discussed this topic, but there is no
agreement on how to solve it yet.

[1] https://lore.kernel.org/lkml/20221127175317.GF4001@paulmck-ThinkPad-P17-Gen-1/T/

Thanks
Zhouyi
> You can browse through all the torture test artifacts here which
> contains everything (build logs, vmlinux, etc).
> http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/
>
> Thanks for your help!
>
>  - Joel
