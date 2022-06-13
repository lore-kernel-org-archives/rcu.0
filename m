Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0460C43334
	for <rcu@archiver.kernel.org>; Mon, 13 Jun 2022 11:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353857AbiFMLbJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 13 Jun 2022 07:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354408AbiFML32 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 13 Jun 2022 07:29:28 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ED3CE11
        for <rcu@vger.kernel.org>; Mon, 13 Jun 2022 03:44:08 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id w21-20020a5d9cd5000000b00669e6796a8aso1106612iow.7
        for <rcu@vger.kernel.org>; Mon, 13 Jun 2022 03:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fEZcgfMVZzqJc7ybxib8fa3FVpwuXcVDtcH0dPsG3A0=;
        b=uJ8jO+Ie14ujn1uFUxXR3XTBBOQzFupkJZGiIX34ns7I/tLYhtBuPhhi5Tfz5cGZxB
         377C+KTyx9pWL1PppYmTtOkdEv1hgcRPaUnzn1Z8WG0SIr7wsdBaqNFwJVXTo7PZOfnW
         PlU3VJePqyahKAHjWnfMWUdeaGgyniIeub1w+rOF4x0fm5Fw5yl4pvYs4rFXmjLkHBfV
         1Q3zUpQRlQPTuNglzaMekoAb5dE9Kyt6xvJvQwmyGBAZmZ42g4TXeMUddZWACsf2ICJ5
         9D2Det/IbpFsVX0Zus+ihfeKoMCBrjAMJ8njNtQpF5lbC8f7c5zCxVAVc01w1DF4HBJy
         1pVA==
X-Gm-Message-State: AOAM531Xg+7iyHo3PzXdDleKI+OE7ayToHRlqt0uDshab7OuuaO+oEj3
        TO5S/VHuNgQwOIAe9YsXAKh6Zlg7WJZdAerWg/77P5VXlgM0
X-Google-Smtp-Source: ABdhPJzYGM8wyFXxpBqce+DRay56fuykYJTlm3Z97gco3gXVLKQDBQe+LJkoivDQ05RRSo2Ln1SRxrgMrCK2ym0icmTglewkd24E
MIME-Version: 1.0
X-Received: by 2002:a05:6638:438c:b0:331:adac:a274 with SMTP id
 bo12-20020a056638438c00b00331adaca274mr23027146jab.192.1655117047472; Mon, 13
 Jun 2022 03:44:07 -0700 (PDT)
Date:   Mon, 13 Jun 2022 03:44:07 -0700
In-Reply-To: <000000000000e2fc3f05e141f930@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad299205e151f7d3@google.com>
Subject: Re: [syzbot] WARNING in exit_tasks_rcu_finish
From:   syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        brauner@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        ebiederm@xmission.com, frederic@kernel.org, hawk@kernel.org,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        john.fastabend@gmail.com, josh@joshtriplett.org, kafai@fb.com,
        keescook@chromium.org, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        netdev@vger.kernel.org, pabeni@redhat.com, paulmck@kernel.org,
        quic_neeraju@quicinc.com, rcu@vger.kernel.org, rostedt@goodmis.org,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

syzbot has bisected this issue to:

commit 09f110d4a1597185a5ed177da8573eec997b7227
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Tue May 17 18:30:32 2022 +0000

    rcu-tasks: Track blocked RCU Tasks Trace readers

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=170f6ee7f00000
start commit:   6d0c80680317 Add linux-next specific files for 20220610
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=148f6ee7f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=108f6ee7f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a30d6e3e814e5931
dashboard link: https://syzkaller.appspot.com/bug?extid=9bb26e7c5e8e4fa7e641
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177b6230080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148207bff00000

Reported-by: syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com
Fixes: 09f110d4a159 ("rcu-tasks: Track blocked RCU Tasks Trace readers")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
