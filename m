Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E22C4332F
	for <rcu@archiver.kernel.org>; Tue, 31 Oct 2023 04:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbjJaENR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 31 Oct 2023 00:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjJaENR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 31 Oct 2023 00:13:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A93DC9
        for <rcu@vger.kernel.org>; Mon, 30 Oct 2023 21:13:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9be3b66f254so770372666b.3
        for <rcu@vger.kernel.org>; Mon, 30 Oct 2023 21:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698725593; x=1699330393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z4CjmHn9gZUNiN39at5TLLAbx3Hn7FVZiQ4wicVe4X4=;
        b=BHA2kzU01eGXhjW4aSTTEwJNg2x6Rs8GMt+i3wDKNdov8OkQBK8NBzZ2feh05z/5l+
         xaHqAAk69my2Jj+ruXyzn9nWYPmvk2HONvtEZgMWz6QQweKxvAHtkDMeL8gRwKsRgUPX
         cZN150cPTQRI5XyOMLRkKKjyNzNUEiuKgqlqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698725593; x=1699330393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4CjmHn9gZUNiN39at5TLLAbx3Hn7FVZiQ4wicVe4X4=;
        b=gl2tSMVbJ0xtc+PTce6BPi0LRBh6HRpU3lHnVdMfXm0NS8ReHjXcPh5xYGEsyNxWsJ
         dB9hk4aOCfHlpI0DLsnas7D6hNXIAU3vyhqbSInNFIKDBpvShzFUYRqWQfl941PHMFT6
         mMR+d3WoWq9OFyG5RSp1PK8YqnzNWZafTy2a7i5s6axpcAepmVPnEV4BziCL44YRRQvg
         je4AWPdQbWnCaXOud7iGc+Ag4zBffBjlMyb2rbvvh+0kw7Gze1xkYIt7mCgfD0cCa5qe
         yQifEf+diZK/B5P5TysfgbtYELrYy4jDJPXhm0ICe062xiZsxrrVmY7iHUBIclPt78iq
         cEtQ==
X-Gm-Message-State: AOJu0YzUfK+KVFziy3TT6FfTcJss/mqZwLB7CrGmHz+3h9tgkJLlnqvK
        1WqCZgP89fQ3Sby+Jw09LL9qOJz/+IvSK+MVF/j04iBh
X-Google-Smtp-Source: AGHT+IHS7MIPvP8CV8zd4AquuwZinVYf0LnKwhbJqeSNx2xw2gdmJA3RllE7nvFQTdNDQZ1wTHu/Hg==
X-Received: by 2002:a17:907:3603:b0:9be:40ba:5f1 with SMTP id bk3-20020a170907360300b009be40ba05f1mr9554567ejc.60.1698725593425;
        Mon, 30 Oct 2023 21:13:13 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id o3-20020a17090608c300b00988f168811bsm257835eje.135.2023.10.30.21.13.10
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 21:13:11 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9c773ac9b15so772389866b.2
        for <rcu@vger.kernel.org>; Mon, 30 Oct 2023 21:13:10 -0700 (PDT)
X-Received: by 2002:a17:907:97c5:b0:9c7:5a01:ffe5 with SMTP id
 js5-20020a17090797c500b009c75a01ffe5mr8290892ejc.5.1698725589631; Mon, 30 Oct
 2023 21:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <ZTuf+xNrfqGjHFDK@lothringen>
In-Reply-To: <ZTuf+xNrfqGjHFDK@lothringen>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Oct 2023 18:12:51 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjEtLocCnMzPx8ofQ=H538uKXSfn+3iZ5zaU7-+3YdjXA@mail.gmail.com>
Message-ID: <CAHk-=wjEtLocCnMzPx8ofQ=H538uKXSfn+3iZ5zaU7-+3YdjXA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.7
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Z qiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, 27 Oct 2023 at 01:33, Frederic Weisbecker <frederic@kernel.org> wrote:
>
> rcu/stall: Stall detection updates. Introduce RCU CPU Stall notifiers
>         that allows a subsystem to provide informations to help debugging.
>         Also cure some false positive stalls.

I absolutely detest this stall notifier thing.

Putting the stall notifier before the stall message does not "help
debugging". Quite the reverse. It ends up being a lovely way to make
sure that the debug message is never printed, because there's some
entirely untested - and thus buggy - notifier on the chain before the
printout from the actual stall code.

I've pulled this, but I really want to voice my objection against
these kinds of "debugging aids". I have personally spent way too many
hours debugging a dead machine because some "debug aid" ended up being
untested garbage.

If you absolutely think that this is a worthy and useful thing to do,
then at the very least make sure that these "debug aids" will always
come *after* the core output, and can't make things horrendously
worse.

But in general, think twice before adding "maybe somebody else wants
to print debug info". Because unless you have a really really REALLY
good reason for it, it's more likely to hurt than to help.

Right now I see no users of this except for the rcu torture code, and
it certainly doesn't seem hugely important there. And so I'm wondering
what the actual real use-case would be.

                  Linus
