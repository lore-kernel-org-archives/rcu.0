Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B23C433E9
	for <rcu@archiver.kernel.org>; Tue,  5 Jan 2021 07:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8EB22582
	for <rcu@archiver.kernel.org>; Tue,  5 Jan 2021 07:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbhAEHdK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 5 Jan 2021 02:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbhAEHdJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 5 Jan 2021 02:33:09 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9905AC061574;
        Mon,  4 Jan 2021 23:32:29 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id q137so27331341iod.9;
        Mon, 04 Jan 2021 23:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cnzmQm5ZMFN9Dtc3fbUF90FMsTzRzNPKJylUEvWnArc=;
        b=lzmlhl5mf5ER472B58sUIvMqx6/BuYn1cUJe0B1NuDvk5nc0jBO4GsLgfuAzRzhuiM
         ML/aJ6aJHX9Z8g1owXyDBAVd+eB74ZNxU3Bh8Pt1oi2qZoJ32ENIShg5dIqB9XeNPLVY
         niCNcwmzX4Brl6VO6HnCHlnCp3Zk/JmnpReiZFaFjgNefxLKoRo8bPBmnhmOFQmFLCIk
         YQrabvVgynuSy9O9M/dY35RPKG+cdK252fpfMvVWCQrodmyQoiX9a3I+CYSBDdq/eJUA
         o/i+65Bf9ERN9vt/ZOD32lrrEuxViDrv8dt7U3/d97LY1OR19NdRU5x/dwpH0c0Ruea0
         F8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cnzmQm5ZMFN9Dtc3fbUF90FMsTzRzNPKJylUEvWnArc=;
        b=RqzM1FMV+PS6Vtnzq/P9k3EPki0HmdwHW3ZMDWjTQ3rV3UtzBsjUDoUcQkTXBxe3P9
         QH8K//AJY+S8em/30/LHJWrYZwcNWW8zbRNrVmL1yFkWv+o986GEfWHZjBAoKC3pCKPb
         CQJRDsVvcplMXgV+MKyhmkf2Ror2EP0hJMALxdESKTK6UdoqpedgNgY5Rlxnoy2lNNu/
         X+yA4Zug/hMK8Q+rCYoxqn3FI8KJ9BVwGeoRhF/xJnogoKUg0BTona0qYonB3CrCPvNT
         4ccnxUjCJBYOY2/tDzz3qfM5GSASiiJuPBMOxAssF79tx4oMM7ZTuXhpGAFBFTeP5PH/
         6Ysg==
X-Gm-Message-State: AOAM532zj1elmwkyCfNoZkYo7vJMVRQQVHwjycp+i/RUhIZsZo5d5+I1
        cEOS4ybX4WqYHB/jURK1m/ZlsW0yjfqBWrvR0s61ygt9xpXyng==
X-Google-Smtp-Source: ABdhPJwZLKF2MmCRNN9b62TQIhNnPubnQLvxjVObKDnh5BD9/qUU4hVdnVPfS/2tJsZjYIgfjf/yAWyx3EOXeB2oqDo=
X-Received: by 2002:a02:5581:: with SMTP id e123mr64508991jab.98.1609831948990;
 Mon, 04 Jan 2021 23:32:28 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 5 Jan 2021 08:32:18 +0100
Message-ID: <CAKXUXMygqbupE_6CK92=PwLw4DjnSuo9-+6iHs_DrZeZ55iRKg@mail.gmail.com>
Subject: kerneldoc warnings since commit 538fc2ee870a3 ("rcu: Introduce
 kfree_rcu() single-argument macro")
To:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Dear Uladzislau,

in commit 538fc2ee870a3 ("rcu: Introduce kfree_rcu() single-argument
macro"), you have refactored the kfree_rcu macro.

Since then, make htmldocs warns:

./include/linux/rcupdate.h:882: warning: Excess function parameter
'ptr' description in 'kfree_rcu'
./include/linux/rcupdate.h:882: warning: Excess function parameter
'rhf' description in 'kfree_rcu'

As you deleted the two arguments in the macro definition, kerneldoc
cannot resolve the argument names in the macro's kerneldoc
documentation anymore and warns about that.

Probably, it is best to just turn the formal kerneldoc references to
the two arguments, which are not used in the macro definition anymore,
simply into two informal references in the documentation.

Best regards,

Lukas
