Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2F0C433EF
	for <rcu@archiver.kernel.org>; Wed, 15 Jun 2022 17:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245041AbiFORrn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357747AbiFORrh (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 15 Jun 2022 13:47:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C7C186E6
        for <rcu@vger.kernel.org>; Wed, 15 Jun 2022 10:47:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v19so17286434edd.4
        for <rcu@vger.kernel.org>; Wed, 15 Jun 2022 10:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7N8FxBu6DA6O7mEvFYXStFEfAYN9n61bDy3OwBXjJ0o=;
        b=JHdk1N03ADEWzySRt7KcxOBPuZaGFXA/8Xyn6d2SSlY9ihVTM6DTBbu1drTtrmQ+M1
         8RPbl/vwMUwgaM0Na3DeW4R1DvZyVGTsvcipdrdnr6LbuwHnx+DPjFA6rx07XSw0xDHv
         KK/3LfmRBtp3+hX2z93IpwI50ZnSgl482NCGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7N8FxBu6DA6O7mEvFYXStFEfAYN9n61bDy3OwBXjJ0o=;
        b=KeZa7hYMiyTiBP/bj2D4i8CAe7kTOzo28KVbiCxi7ZwhldUr7VGWN79SZnzAkdKCvO
         GJMdsNhvOW8rYFxLoPkOWb8TWfIqxWZm0v9NQ2JMRA13cglU988Mn0KbpAmMBLVdePMp
         x74R9cMpHDoTQL3bvLM4UvUPTzJdUc6aMW15L1hBtu6G9G0MwvV+JnV7Z7lodRiKB/5o
         ElxVCkfiNtkMZYnokfVnQdkx9MuXi+Y5LY1d6YFRqesprOMdU1GVurvzIoi7oMrasqhU
         23y2OmK9LmDLMiV4dPwdjSvzQEtTDxRtbNEI7Ldj9a23j3hbqgROVhegcWYC/GHjuP7L
         O/Ww==
X-Gm-Message-State: AJIora+gMdy7hZNjz4EhOl/O/0EXGLyZ2H3zTka9wjYicwP0IFq+zK2J
        v+RleKdZUjCYZ5RZGd4GTTjC3lnqJWlXO0ULv7g=
X-Google-Smtp-Source: AGRyM1vfbs1Xfrig6BavS/Arst6eUogQVkks/5ecJglzgLZhEwlt91uDzZ4STQew+iY+jE+2Ap2hOw==
X-Received: by 2002:aa7:d456:0:b0:42d:d7d9:34c1 with SMTP id q22-20020aa7d456000000b0042dd7d934c1mr1141391edr.21.1655315253692;
        Wed, 15 Jun 2022 10:47:33 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id r21-20020a1709067fd500b006fec5cef701sm6502910ejs.197.2022.06.15.10.47.31
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 10:47:32 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id s1so16336934wra.9
        for <rcu@vger.kernel.org>; Wed, 15 Jun 2022 10:47:31 -0700 (PDT)
X-Received: by 2002:a5d:414d:0:b0:213:be00:a35 with SMTP id
 c13-20020a5d414d000000b00213be000a35mr875787wrq.97.1655315251112; Wed, 15 Jun
 2022 10:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220615162805.27962-1-pmladek@suse.com> <20220615162805.27962-2-pmladek@suse.com>
In-Reply-To: <20220615162805.27962-2-pmladek@suse.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Jun 2022 10:47:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com>
Message-ID: <CAHk-=wgs38ZrfPvy=nOwVkVzjpM3VFU1zobP37Fwd_h9iAD5JQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] printk: Block console kthreads when direct printing
 will be required
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>, zhouzhouyi@gmail.com,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        rcu <rcu@vger.kernel.org>, linux-rockchip@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Jun 15, 2022 at 9:28 AM Petr Mladek <pmladek@suse.com> wrote:
>
> BugLink: https://lore.kernel.org/r/20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1
> BugLink: https://lore.kernel.org/r/CAMdYzYpF4FNTBPZsEFeWRuEwSies36QM_As8osPWZSr2q-viEA@mail.gmail.com

Other thread discussion about this exact thing:

   https://lore.kernel.org/all/CAHk-=wgzRUT1fBpuz3xcN+YdsX0SxqOzHWRtj0ReHpUBb5TKbA@mail.gmail.com/

please stop making up random tags that make no sense.

Just use "Link:"

Look at that first one (I didn't even bother following the second
one). The "bug" part is not even the most important part.

The reason to follow that link is all the discussion, the test-patch,
and the confirmation from Paul that "yup, that patch solves the
problem for me".

It's extra context to the commit, in case somebody wants to know the
history. The "bug" part is (and always should be) already explained in
the commit message, there's absolutely no point in adding soem extra
noise to the "Link:" tag.

And if the only reason for "BugLink:" to exist is to show "look, this
tag actually contains relevant and interesting information", then the
solution to THAT problem is to not have the links that are useless and
pointless in the first place.

Put another way: if you want to distinguish useless links from useful
ones, just do it by not including the useless ones.

Ok?

                   Linus
