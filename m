Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8374C433FE
	for <rcu@archiver.kernel.org>; Wed,  1 Dec 2021 20:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353062AbhLAUxx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Dec 2021 15:53:53 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:55276 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239936AbhLAUx3 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Dec 2021 15:53:29 -0500
Received: by mail-il1-f198.google.com with SMTP id f5-20020a056e02168500b002a169f37fbcso28787149ila.21
        for <rcu@vger.kernel.org>; Wed, 01 Dec 2021 12:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=X/WRQR8STDSXJRhWuJ7l+MpIYKViU5igfD9Z/w6cwnE=;
        b=J0xREsy2sFltK4YZBBLknffzYeCfSYTAWSg71iQP+aCB3x9M3c3yCo+Aj7HVUxienW
         Q6bYC4C30jpIHInVj1nfn6PvrPJfntKIDUDUZJHiBcJy00+J/BbaNarIv9aMwCwggPmy
         zdmL103TrfUcjS/Rh3E7kSYqmcPiYVw2lDiqya1O8OX5ODirQlBNwzv+VqcVXs9kV0yL
         lgMptNEUQaafYlObyepsU7AUUSaDtp6C2D3V0LVwarF68nh9+R2PIpfQzcsmI3yossM0
         6GEI4s5eQ6wUpwXsRr0TQOUG7i9dBB+B84CmDYKkqQlrEeQ5tnFr0cKLMWeoiYaQjF+g
         pmMg==
X-Gm-Message-State: AOAM531Q9QE11IjR3fCHoL1VpeOsdxqRFpfns0w2jQVFrSkq3hDFspL0
        NEvpBz+8Pe1BU52+NFCgMbLJxr+eeN3s5FJbbxdDBt32rJl1
X-Google-Smtp-Source: ABdhPJxwnTjayukxQsPm7f3vzoFuy8C1JldbQMohbfblKSqInY3rP+nF24H24uBktfOukSFRQgYKFbRtf7c4JSZgMRbBhRziF+lR
MIME-Version: 1.0
X-Received: by 2002:a92:d291:: with SMTP id p17mr1253204ilp.154.1638391807990;
 Wed, 01 Dec 2021 12:50:07 -0800 (PST)
Date:   Wed, 01 Dec 2021 12:50:07 -0800
In-Reply-To: <00000000000069924b05c8cc3b84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7e3ee05d21bd19d@google.com>
Subject: Re: [syzbot] WARNING in trc_read_check_handler
From:   syzbot <syzbot+fe9d8c955bd1d0f02dc1@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, jgross@suse.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        mingo@kernel.org, namit@vmware.com, netdev@vger.kernel.org,
        paulmck@kernel.org, peterz@infradead.org, rcu@vger.kernel.org,
        rdunlap@infradead.org, rostedt@goodmis.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 96017bf9039763a2e02dcc6adaa18592cd73a39d
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Wed Jul 28 17:53:41 2021 +0000

    rcu-tasks: Simplify trc_read_check_handler() atomic operations

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1281d89db00000
start commit:   5319255b8df9 selftests/bpf: Skip verifier tests that fail ..
git tree:       bpf-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=9290a409049988d4
dashboard link: https://syzkaller.appspot.com/bug?extid=fe9d8c955bd1d0f02dc1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14990477300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=105ebd84b00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: rcu-tasks: Simplify trc_read_check_handler() atomic operations

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
