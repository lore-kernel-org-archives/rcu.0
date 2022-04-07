Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FB1C433EF
	for <rcu@archiver.kernel.org>; Thu,  7 Apr 2022 10:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbiDGKJv (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 Apr 2022 06:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiDGKJu (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 Apr 2022 06:09:50 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE57022EBD5
        for <rcu@vger.kernel.org>; Thu,  7 Apr 2022 03:07:46 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id p21so6173621ioj.4
        for <rcu@vger.kernel.org>; Thu, 07 Apr 2022 03:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+20wf0GtDSgwHKQPUIDUWXlshKcm23UV/5tifZ3qNQ=;
        b=CErb0NImHMXyWQaIX785WKOmy6LabafXklmq4w2GQC1o9NrCsnU5agIsDqEvUbNrtV
         LIUmI2DcrX6P59Z01TArpie430Im7o9yO77jivJ1UNmaOtloUOa1gro0ZbQZTPSvfOav
         oNMdgoK4CYEX1Wbawm01PtyLEo+kUhv4OzP4UloVbsrksGUDgbM1JlS652xyxJqeUL/U
         dlAPav2DQzkM5zixnH/llhORre1N2pE+E7IG3rznR7kXV9HFnvICKAOgY2c9EbnU3PYX
         JqS3INeNlD0S2Hvx9om7ZFfo2U0O+uUl51TubDHv3rJxSx7CAQCWHu7qi0Ruzh7B3pF6
         8P2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+20wf0GtDSgwHKQPUIDUWXlshKcm23UV/5tifZ3qNQ=;
        b=iLk9wGTJjY0cyWzBw8bu5CiKBkxmgmxf40PdZCske2JDxXX2ih71mm77IMSiPHkkxJ
         TlSr4XQkaFwZ5PMRKcuGbeJ6k7T5JFLCyX0/hnCzyQg2PA1+JtAVXo0Blnvnj/BzNX13
         PVp+V98r4UIY7TzqzkxUYHyIJbFUbesuQ/tZI9N1+8raWaaxrYW+MA8fnGFfmja4FPtL
         bRZuWwxb5pNh0LUZ4MjM5dNlUHMLHy88uuTIQkbxOb8mvlNqxLDZyPDrDFvMUv9lPlw5
         l5E9f1y0jXOu3bcAcbY0FCCFjC0bcA1FrqX/MkiZuprtlm6VP7y5ypQBEWvQHSRr2nMi
         yvRg==
X-Gm-Message-State: AOAM531jwDaZMTy5VojWm2z7Wmx/t7ijrvksz17gF0T4KbIhg0kozRdT
        qlDiERDzLBVyXFbsbX7o6fo89HJQQ6vP3zNWG/hwzjChWlw=
X-Google-Smtp-Source: ABdhPJxUPNYRorI9eAmMjOiqWAV3/Dg4IX9tjX/hdBgbEMkZi8T/5za5C9ftAX0TYRjxX+B0fSqX6M9cZ3U/vLNuKWw=
X-Received: by 2002:a02:ab87:0:b0:324:2157:2b4 with SMTP id
 t7-20020a02ab87000000b00324215702b4mr1514815jan.186.1649326065883; Thu, 07
 Apr 2022 03:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <CANiq72k+5Rdj7i3Df2dcE6_OPYPXK3z5EWLKnY56sSMz4G3OvA@mail.gmail.com>
 <CAABZP2z64aYWfVSdXHaQopWc+BAbJJUGqtrju2iWER3DDTDFWg@mail.gmail.com>
 <20220406170012.GO4285@paulmck-ThinkPad-P17-Gen-1> <CAABZP2zhZaN0+KqP7oMoyXTSkDhLjZwWvnj7coa1ZVve9M+jsQ@mail.gmail.com>
 <20220406195011.GP4285@paulmck-ThinkPad-P17-Gen-1> <CAABZP2x8_783jhEhC3AozH9=xj40UO-rZT2BRJsg5gaLdBz=9w@mail.gmail.com>
In-Reply-To: <CAABZP2x8_783jhEhC3AozH9=xj40UO-rZT2BRJsg5gaLdBz=9w@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 7 Apr 2022 12:07:34 +0200
Message-ID: <CANiq72mYXnQo_Y39k23rY-rdJay8GEPJ8MhU-y7-bjkw=zRC+Q@mail.gmail.com>
Subject: Re: rcu_sched self-detected stall on CPU
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Apr 7, 2022 at 4:27 AM Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
>
> Yes, this happens within 30 seconds after kernel boot.  If we take all
> into account (qemu preparing, kernel loading), we can do one test
> within 54 seconds.

When it does not trigger, the run should be 20 seconds quicker than
that (e.g. 10 seconds), since we don't wait for the stall timeout. I
guess the timeout could also be reduced a fair bit to make failures
quicker, but they do not contribute as much as the successes anyway.

Thanks a lot for running the bisect on that server, Zhouyi!

Cheers,
Miguel
