Return-Path: <SRS0=MKz8=Z3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7932DC43603
	for <rcu@archiver.kernel.org>; Thu,  5 Dec 2019 17:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F8224648
	for <rcu@archiver.kernel.org>; Thu,  5 Dec 2019 17:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="rbjUHsd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730139AbfLERlp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:41:45 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46827 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729711AbfLERlp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 5 Dec 2019 12:41:45 -0500
Received: by mail-lj1-f195.google.com with SMTP id z17so4500487ljk.13
        for <rcu@vger.kernel.org>; Thu, 05 Dec 2019 09:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1l0ZCNFvkCCXW1nNKYzmevuG1/94tIufhroE2k0uins=;
        b=rbjUHsd+NgZ6Eo0amb71FB0ahpUoOxKt0cjgXodsJfiz8whztRAWxynmFZW+YJE3EA
         VoyWf9LvlBFymtZ1CTEQeQzgNqKO9IDH+IHcozNpwJyPIbQkSazQpRenkQQyfT3qMiSD
         dllQdgZvOahCmL9n8Upbclc8xMcuNsc3hbt1j7GFCSNbr4DKQxpfldToEvoKorMHjQfv
         Y+Hlo6d6jpgbsiy5cDEDo/g/HwSOQ965dnBedLTSIcFcyLLqoNjeSaGYzFI5CfPMx5LD
         XD4dvz9uldLPPMVGM0vZna/uZaMks4BEzYpVeCW6R94nREHntKqxc0IaaYqqR7nZAah7
         uQ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1l0ZCNFvkCCXW1nNKYzmevuG1/94tIufhroE2k0uins=;
        b=LXohvBkwPFlZsay6oQXtnS6Z49DJeRv2CcJ3FKmT9yY0sJKHwlhfcnekphyRihbglT
         5Fpf7wzvwMPZSP3z8qL6y/hiohdykET0JrPKITcZk3mcEdHJg5GxgIzgu1vRbTvQxMHI
         G9yHTUUzvD3gzEPgzYMfA2NuwwBn1JSE88ZiJiB+31NynTTFtUXK97JaRTYZhAG57DzM
         n+VJvFmIqO5V/6QbR354AnIg6Xj1VZEiNYMqHTLr020fHNyH7BGyoGNHSv+dtsesZxYx
         t4tSHqA7T4XXlUIPyT7p7lvfC1zHahpT8iOcwz3nuq1Es/WJmqBTqpq2X4zjwZQXfAKC
         /Zpw==
X-Gm-Message-State: APjAAAVWwnLeSiTRa1ew2x1lkLHWbsD4/c/tOA4Y1tkpy2mAkZ6rgQw/
        D10Ryt48GHMBWP3pBFTgv9tSEflaTB1ALdlStPr6
X-Google-Smtp-Source: APXvYqyYgbs28BlJJILWmpbXmygxma4FhV5XHOkHsK+M+miwEXnRUZpRTRD8oT/FKPAmlksj74bVxhENXzZKLgnNSRY=
X-Received: by 2002:a2e:3207:: with SMTP id y7mr5433792ljy.57.1575567702435;
 Thu, 05 Dec 2019 09:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20191122093306.17335-1-jeffv@google.com> <CAHC9VhQ-piMePyfOeLsrAtgSCG5iWjk9xFbjOvURe3WLD-z89g@mail.gmail.com>
 <CAFqZXNun_-aWx19UKUMfiYuQuttxCgMOoAczBAddDv3yaCZyxw@mail.gmail.com>
 <CAHC9VhTwct8daQoXFg4JpHkWUhijQFn8D0Tq=VX989mq3TVfvg@mail.gmail.com>
 <CAFqZXNvQV+syzOE0CGczzTvi9g65AUT8bdsG0YN6NcHzd5GVHQ@mail.gmail.com> <CAHC9VhSVsmu6hjmUAi2wM6wAkkQnUDx7MM1G8Ln9OLAzwFmz6A@mail.gmail.com>
In-Reply-To: <CAHC9VhSVsmu6hjmUAi2wM6wAkkQnUDx7MM1G8Ln9OLAzwFmz6A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 5 Dec 2019 12:41:31 -0500
Message-ID: <CAHC9VhR+hYnLoMkAPuRNJygk+dOoNyhooNuz3Ma=F07b9gh=rA@mail.gmail.com>
Subject: Re: [PATCH v9] selinux: sidtab: reverse lookup hash table
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Jeff Vander Stoep <jeffv@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Jovana Knezevic <jovanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Dec 5, 2019 at 9:08 AM Paul Moore <paul@paul-moore.com> wrote:
> Thanks for the double check.  Unfortunately my kernel build locks my
> test VM in early boot; it appears to be non-SELinux related and since
> the test build is based on selinux/next+patches (which is based off
> v5.4-rc1) I imagine there might be some unrelated problems in the
> build.  I'm going to rebase my test build to Linus' current and try
> this again.

Hmm.  I haven't done any debugging yet, but the BPF tests are failing
(they pass with kernel-5.5.0-0.rc0.git5.1.2.secnext.fc32.x86_64):

1..15
ok 1
Failed to load BPF prog: Invalid argument
not ok 2
#   Failed test at ./test line 68.
Failed to create BPF map: Permission denied
ok 3
Failed to create BPF map: Permission denied
ok 4
Failed to create BPF map: Permission denied
ok 5
Failed to load BPF prog: Permission denied
ok 6
Failed to load BPF prog: Invalid argument
ok 7
client: Using a BPF map fd
client: Connected to server via ./test_sock
server:  Accepted a connection, receiving message
client: Sent descriptor, waiting for reply
server:  Received a descriptor, fd=5, sending back 0
client: Received reply, code=0
client: ...This implies the descriptor was received
ok 8
Failed to load BPF prog: Invalid argument
client: Using a BPF prog fd
client: Connected to server via ./test_sock
sendmsg: Bad file descriptor
server:  Accepted a connection, receiving message
server:  Received no descriptor, sending back 1
not ok 9
#   Failed test at ./test line 118.
Failed to load BPF prog: Invalid argument
client: Using a BPF prog fd
connect: Connection refused
ok 10
client: Using a BPF map fd
connect: Connection refused
ok 11
ok 12
Client request_service_provider_fd() failing command BR_FAILED_REPLY, exiting.
ok 13
ok 14
Failed to load BPF prog: Invalid argument
Client request_service_provider_fd() failing command BR_FAILED_REPLY, exiting.
ok 15
# Looks like you failed 2 tests of 15.

-- 
paul moore
www.paul-moore.com
