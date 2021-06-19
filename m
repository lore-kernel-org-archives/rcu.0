Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE60C2B9F4
	for <rcu@archiver.kernel.org>; Sat, 19 Jun 2021 16:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3EC061206
	for <rcu@archiver.kernel.org>; Sat, 19 Jun 2021 16:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhFSQ4S (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 19 Jun 2021 12:56:18 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:47939 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbhFSQ4R (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 19 Jun 2021 12:56:17 -0400
Received: by mail-io1-f70.google.com with SMTP id w2-20020a5d96020000b02904d5a6cb5d72so6605521iol.14
        for <rcu@vger.kernel.org>; Sat, 19 Jun 2021 09:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QqIncrQU8u3oTCnB+Mpzxl6+UwwC6+HMM9p8ltzPHS8=;
        b=FaG5agmNuDmx/magrSlLn8aTNTVXqjTGafNpTkYiEdHcYyqgo8Q3vGcYqnM/l0cL0Q
         gEeJERTTMFi6t+g0xD8xnfZRaJuQx0qdGWW9sfTlR+pVhwWPwlPbMEcbRpapzxyDcG2A
         afSA8ZzpNZAVvfO0d8mrSrqCRyXzyuAFD4FkQHMAb/5+w+ADidIJayV8vh/duSMMS05O
         ebBeogHaVwVrnxn5UGn2bDOGLMR1US7UElcHfVFN/hgHzgAHo5B5YiHM1zwoOMcDFBSo
         gHt+828tTf71F399A2c+90ODv5Aflk/qpgZKCyVgfYquuMOmq/wdWLxWQwDprAUmVLTB
         MQpg==
X-Gm-Message-State: AOAM530mhKkgnrW85I01NqUnE/VlsxdR+NUSdyV/ob65Y7vVOCUvt6M3
        /MNfO8DVzlrRb47bFJ1vYuk3OmqpBgoNqzbgsPEI0sylLgkR
X-Google-Smtp-Source: ABdhPJx/AfnH2IlS/TiDpgCKO8HJ1dF/+Qf9wLPerlasfa7aKwjtTw6wDoV8Sg0G1dCQZ9I9Y1q/4o9tQB4bG00bf9WeDJQtc5Ow
MIME-Version: 1.0
X-Received: by 2002:a02:94af:: with SMTP id x44mr8962347jah.79.1624121646170;
 Sat, 19 Jun 2021 09:54:06 -0700 (PDT)
Date:   Sat, 19 Jun 2021 09:54:06 -0700
In-Reply-To: <000000000000f034fc05c2da6617@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cac82d05c5214992@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in check_all_holdout_tasks_trace
From:   syzbot <syzbot+7b2b13f4943374609532@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org,
        axboe@kernel.dk, bpf@vger.kernel.org, christian@brauner.io,
        coreteam@netfilter.org, daniel@iogearbox.net, davem@davemloft.net,
        dsahern@kernel.org, dvyukov@google.com, fw@strlen.de,
        jiangshanlai@gmail.com, joel@joelfernandes.org,
        john.fastabend@gmail.com, josh@joshtriplett.org,
        kadlec@netfilter.org, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        mathieu.desnoyers@efficios.com, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, pablo@netfilter.org,
        paulmck@kernel.org, peterz@infradead.org, rcu@vger.kernel.org,
        rostedt@goodmis.org, shakeelb@google.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yanfei.xu@windriver.com,
        yhs@fb.com, yoshfuji@linux-ipv6.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

syzbot has bisected this issue to:

commit f9006acc8dfe59e25aa75729728ac57a8d84fc32
Author: Florian Westphal <fw@strlen.de>
Date:   Wed Apr 21 07:51:08 2021 +0000

    netfilter: arp_tables: pass table pointer via nf_hook_ops

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10dceae8300000
start commit:   0c38740c selftests/bpf: Fix ringbuf test fetching map FD
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12dceae8300000
console output: https://syzkaller.appspot.com/x/log.txt?x=14dceae8300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6380da8984033f1
dashboard link: https://syzkaller.appspot.com/bug?extid=7b2b13f4943374609532
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1264c2d7d00000

Reported-by: syzbot+7b2b13f4943374609532@syzkaller.appspotmail.com
Fixes: f9006acc8dfe ("netfilter: arp_tables: pass table pointer via nf_hook_ops")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
