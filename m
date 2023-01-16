Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D301CC46467
	for <rcu@archiver.kernel.org>; Mon, 16 Jan 2023 17:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjAPR0y (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 16 Jan 2023 12:26:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234554AbjAPR0W (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 16 Jan 2023 12:26:22 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8A62749D
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 09:03:44 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id s25so30625148lji.2
        for <rcu@vger.kernel.org>; Mon, 16 Jan 2023 09:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=20AkGUFtx8eZwa3s8iWfJyXcqMTu7mAvzflDGbccoRA=;
        b=acDItFZw1FFvCQJ/IxA10Jj5c4unCna5xy2gZEiRYRE81DZN5cT9MsK/Yc/UbgiwEG
         +7c0tgbpp6UYBfup0rYInsL/eLiG3pRCLjle3p7vOT0EbHJdMnH6u1TR4nYz7b4r9rSd
         1cztYkHepSa3wG0Rb2pRJ79haYkDr2JKuRenc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20AkGUFtx8eZwa3s8iWfJyXcqMTu7mAvzflDGbccoRA=;
        b=TO2nz+0INHSegSxdS5TpGFOV50PYhN7eXmsuz2OmeD+UBxMJFJsJqrJsJAB/M11lJP
         X/dUuJ0ii45sS5mv8n21ifHlHW9rMhSj8bfF4ctZe7/HRxm3GH5k2PO0XZ6e0jFZZXtI
         7VrVAw90EysJKJo236wfIvlb0XJQko6kQjcTGvNB2nW2+GuevWAApeSnzdXW1O44DyN3
         ESXdljcqbR/MGYTorVxgz1sMRrwh1E5pwcsH/YOGp40NH+YJEhvJDyIXWEtsTVMVmloP
         P79uYYgowq8h3/PnF1Y+FxCF7HitRn3uuhhDC1+uTYhwIp2aMjn0jFEh8+mJDYunP9GO
         +rtg==
X-Gm-Message-State: AFqh2kpic54Da3YV/H0PgLmGtSuNRqE5tyAU+R7D5LH30jTpAE1E5E/m
        WUtsY4JImNtaa94DT22/oDFrMcQ40ttmbvdip6IzVhTow0f3IRzd
X-Google-Smtp-Source: AMrXdXtUJs9sGe4QLlHx25ut5uctLhMIxw/f/WHAtArvKpN5zc7EScTDVUckE6dYVq3z9JGGAidwcIlqH2k0MsJGp4M=
X-Received: by 2002:a05:651c:1050:b0:288:a393:7e34 with SMTP id
 x16-20020a05651c105000b00288a3937e34mr39400ljm.356.1673888622608; Mon, 16 Jan
 2023 09:03:42 -0800 (PST)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 16 Jan 2023 12:03:31 -0500
Message-ID: <CAEXW_YQB1Wm3YhgUP8S9a4drgvDasu3s+zyt3j9Wwpt83W=W=Q@mail.gmail.com>
Subject: arm64 torture test hotplug failures (offlining causes -EBUSY)
To:     "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     rcu <rcu@vger.kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello,
I am seeing -EBUSY returned a lot during torture_onoff() when running
rcutorture on arm64. This causes hotplug failure 30% of the time. I am
also seeing this in 6.1-rc kernels. I believe see this only for CPU0.

This causes warnings in torture tests:
[  217.582290] rcu-torture:torture_onoff task: offline 0 failed: errno -16
[  221.866362] rcu-torture:torture_onoff task: offline 0 failed: errno -16

Full kernel log here:
http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/TREE04/console.log

Any ideas on why this is happening and only for CPU 0 (presumably the
boot CPU)? I'd personally need these warnings to go away for my tests
as this causes rcutorture's tests to not cleanly pass for me. It
appears remove_cpu() -> device_offline() is what returns the error.

You can browse through all the torture test artifacts here which
contains everything (build logs, vmlinux, etc).
http://box.joelfernandes.org:9080/job/rcutorture_stable_arm/job/linux-5.15.y/7/artifact/tools/testing/selftests/rcutorture/res/2023.01.15-14.51.11/

Thanks for your help!

 - Joel
