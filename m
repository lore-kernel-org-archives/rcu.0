Return-Path: <SRS0=oLBG=C6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87734C35257
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 19:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3392223E
	for <rcu@archiver.kernel.org>; Mon, 21 Sep 2020 19:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600717605;
	bh=q8mNeB6d5pdUpaLtBaFdvRcF84yZmYdtbXkciz1kl6M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UZWPHjOhrOzoj2bRneC07deUKEBl6HbVjrVQBwXziI81rRyZ+otoU05k69N/hRBsl
	 U4XRgulXcuDa0JJaMMzUaO40UE/MRyxfXTPvwjVjU0d4jBHehj1yk86h9k0qM7iOcX
	 IvSNt6coizUMTQsJlp/JvfL2dAQARaU/euLf2XbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgIUTqn (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 21 Sep 2020 15:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbgIUTqn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 21 Sep 2020 15:46:43 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC86C0613CF
        for <rcu@vger.kernel.org>; Mon, 21 Sep 2020 12:46:41 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z17so15347098lfi.12
        for <rcu@vger.kernel.org>; Mon, 21 Sep 2020 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O12KA4gpgToULD4PEEiFpucgyTXt+AD9I01ESnbP5BA=;
        b=Yc+fNIB55As9EBStdgZeN5V81wLA0O4LLOri5v6nxAqW2Ne9yFalKF0kKRt2fZRmXs
         kQQrl+rPZpGeMP8t1q6slpTqtqWj2fWWHnyXL0i4LVExozcWy/FBIayrv4hER3Ye9WYQ
         N0GCH/VJqsPMnMsg31CNnkyIVZssjMPy1KtVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O12KA4gpgToULD4PEEiFpucgyTXt+AD9I01ESnbP5BA=;
        b=ssQ9ttq+G9jcV0NA6jOupqxqhRpayhcLGFNJchtJm3GtJjpO+DRzANZ+FdJmgzWqOc
         m3e8/6Vojr+KpoG2frwJ3Diy3r5eI0EofWpT/3/6gK4MI8ge8ec61EbH/jvNTX3JXcvh
         pbJrO5vYt197pxr/kn/cr5NB+5zYAE949CWnV+cfyyfbpcDLPPeArSYrJ0F/eL0FNYle
         4d5dZ7MIx1WUf+gdONoqw9k8Q2IMgLGCFE1E4IHlVSNsbIbA6NTheQ0awlgJ2GqDfEdN
         JbUty1oGFHhc6fJ6dQ6IIR+5D4Hx7fxTtJkqlxDetCeZMsNK70ujAdWg05Hucpx/9kUD
         DG2w==
X-Gm-Message-State: AOAM5335FBJEMYEMIv5s/X2vpAuF8o7Jd/j8rq/knmI94ICqaQk4ieLO
        46eTjoBlUSJR+Q228ShQQqngpW8ZRoRCBg==
X-Google-Smtp-Source: ABdhPJwKH1v+7rBNDtqMgSSnOqQ1TBVJFM9XfE6E4oEj8VQo2hJrxVx7j4iaDH6BzfDIuEhR0+VhHQ==
X-Received: by 2002:a19:254:: with SMTP id 81mr436477lfc.405.1600717599914;
        Mon, 21 Sep 2020 12:46:39 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id q17sm2814569lfd.37.2020.09.21.12.46.38
        for <rcu@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 12:46:39 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id y17so15393835lfa.8
        for <rcu@vger.kernel.org>; Mon, 21 Sep 2020 12:46:38 -0700 (PDT)
X-Received: by 2002:a19:e00a:: with SMTP id x10mr525249lfg.603.1600717598578;
 Mon, 21 Sep 2020 12:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200921193703.GA20208@paulmck-ThinkPad-P72>
In-Reply-To: <20200921193703.GA20208@paulmck-ThinkPad-P72>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Sep 2020 12:46:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh52SXRqz9CndHZqjuA1GO7MDdNusQ7CgDOpLkD8ocZaA@mail.gmail.com>
Message-ID: <CAHk-=wh52SXRqz9CndHZqjuA1GO7MDdNusQ7CgDOpLkD8ocZaA@mail.gmail.com>
Subject: Re: [GIT RFC PULL rcu/urgent] Fix rcu-tasks compilation warning
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Sep 21, 2020 at 12:37 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> This bug was reported by Laurent Pinchart (CCed),
> who would like it fixed sooner rather than later.

I'm assuming that sentence and me being cc'd means that you'd prefer
to get this merged directly rather than go through the usual -tip
shenanigans.

I've pulled it.

             Linus
