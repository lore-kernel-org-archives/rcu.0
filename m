Return-Path: <SRS0=4RPF=5D=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9981C4332B
	for <rcu@archiver.kernel.org>; Wed, 18 Mar 2020 20:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA4E20BED
	for <rcu@archiver.kernel.org>; Wed, 18 Mar 2020 20:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N4LnSddq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgCRUyV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:54:21 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33128 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgCRUyU (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 18 Mar 2020 16:54:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id d22so22108300qtn.0
        for <rcu@vger.kernel.org>; Wed, 18 Mar 2020 13:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hy5qm/HoUUr4+Nf3BF/DCL1M5z8PuuCJBXzeH7Xw+kY=;
        b=N4LnSddqyjrj35FEVCaWDHim03KW+ZMlw6qB2LGHay3tvrKmDKnOjhDE1BDP5LjjQ3
         FY6hM5XnjpfTcrJgfZwC9eNgRb2L0XbMHVXs32uIu9T7ragvkTHGOyNnU7Yf2eRdCJE4
         3I34Il+w8b2WlNqaNKTgy+Yz/V7aplf9yBmx8lUj/sa0pndkwQVgTed31zYlC/Jrht0t
         p52hIjkurSF/WCqgML1XoV0ubBQi5ua4ZdQ67Bb9l8CNm72Iph64ACpCtzJjzKqgCxTy
         XqZ9eOArX3AGMRBIKcOZIUimcnYMhYUpq4pe8Jxyj1zVeUKecaMY9CRKdllFXWrv3P6B
         ygcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hy5qm/HoUUr4+Nf3BF/DCL1M5z8PuuCJBXzeH7Xw+kY=;
        b=gt+3XZL6qLWPNo54v48tzgE2HIaCJAV7Qawy1Tb6064PM3zw4d0KSz4pRvzGQmZOMo
         208RnmLJSHWH2H5R9UgIe42de8n3C12Zj1XJm+/ZOZdOm6HZyYn46HXsitueZeYq0zjJ
         Hy5OmGhY0UXmXyBiB3YT2YmwRzYmwJo/+9omIkQjmJcTCswPHQsZrukAuH+dTJMLE4y2
         h8WCO2x7SWzQAIpziQQiNFXAKmjrZlVMOP41UldESzHsPTY3KdNaVzMl8mquTOu76RXl
         uVi5bkFiylg6rMHGf8VlKWq57dK8ZLHC/40FMbR8+cXVg+/UCRmWXpXno8wdxJ7nSkXJ
         Y3lQ==
X-Gm-Message-State: ANhLgQ1ImtZV3j0RWRqib/0nz4zdMRsov/7Q79xl674EEuyKRYJrMse8
        wRqg3Ng18zgWms6E0XSMjzBiTLxIIq9hA4l08Orqiw==
X-Google-Smtp-Source: ADFU+vtmmSWS+aIMzUy5/s+2hhcAShSPdK7KLUDMp6FBmd1LA5Z7u8QejSBWyleiEI9eBwNGxK3e7ELqI7QZGMIbzUo=
X-Received: by 2002:aed:36a5:: with SMTP id f34mr6299431qtb.57.1584564859557;
 Wed, 18 Mar 2020 13:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ae2ab305a123f146@google.com>
In-Reply-To: <000000000000ae2ab305a123f146@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 Mar 2020 21:54:07 +0100
Message-ID: <CACT4Y+a_d=5TNZth0dPov0B7tB5T9bAzWXBj1HjhXdn-=0KOOg@mail.gmail.com>
Subject: Re: linux-next build error (8)
To:     syzbot <syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Mar 18, 2020 at 5:57 PM syzbot
<syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    47780d78 Add linux-next specific files for 20200318
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14228745e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b68b7b89ad96c62a
> dashboard link: https://syzkaller.appspot.com/bug?extid=792dec47d693ccdc05a0
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+792dec47d693ccdc05a0@syzkaller.appspotmail.com
>
> kernel/rcu/tasks.h:1070:37: error: 'rcu_tasks_rude' undeclared (first use in this function); did you mean 'rcu_tasks_qs'?

+rcu maintainers

> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
