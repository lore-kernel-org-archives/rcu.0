Return-Path: <SRS0=Gqt/=DB=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C880C4363D
	for <rcu@archiver.kernel.org>; Thu, 24 Sep 2020 02:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25AF42137B
	for <rcu@archiver.kernel.org>; Thu, 24 Sep 2020 02:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pR6nXCY3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgIXCq3 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 23 Sep 2020 22:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgIXCq2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 23 Sep 2020 22:46:28 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70265C0613CE;
        Wed, 23 Sep 2020 19:46:28 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id u8so2180808lff.1;
        Wed, 23 Sep 2020 19:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+eNHoJ3hPvMPQqYtY4sJ1VsIJccrVuHfsFJyXxlV7E=;
        b=pR6nXCY3wR0y8cB6ivNkWm2/LCSJzNGakD3yYn1i0VkIWdJgdfEdgOenMhMAkxahv4
         a1zIhV5TOezq+fIfL9QlYGHv/EBJyE64jif9ComBhj3FyzO48xLSTKzc+r5sMxgTYLfg
         kQq4ycdxSQ9Hnw2aOEnSlPUeULpR6O/a7eM5yWvxo8xHY8/Ova9R43llg55n576uV5zM
         L37V28MDD7vEa5nEVhgJuUWnMGQaV4phq2Bd4NtiKem5rxUTQKKJLtSi97fgVwcMdG1u
         sb+Q68E4+83OsxcxUqHv57Cvw+q19yusxn7Nzwr0AVvUrHT0+XuKuv4a69Sn/g0oOnnh
         M12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+eNHoJ3hPvMPQqYtY4sJ1VsIJccrVuHfsFJyXxlV7E=;
        b=dtaWHya9Skw0PJZHTFNb1Blscug2nEg21qJcA1Zmk0otmruqdvQBScsRrKrUhhrXT0
         lRo0C/F4YLNbsvQd1KVgUKL06G/IS9zgq5yzqndBiCTbFLR600LbFFB5tc8fnRmdI1Rw
         t0eleYUIzF9VrZkjYPpU7+7bKbqXkQP+rKvHdLvhPV+A+cAQSnVym4AcdxonCHmgT0bB
         3sbVe1AYvltIydPV3MaLstRsJ7JtJHDGaKcD6Jg1GiLCBIV9ESUfitv69Hr1zi0MmwaO
         jse3uoz/WfMQDjkBg31TvWwF/4GDa7bKSKhkkwlo+HXCn0AZ6smB83mZVPhCR1sxZKuR
         ZdbQ==
X-Gm-Message-State: AOAM533GbPt7N505XQOz4mSPpvyoMsxfbARDQaBJPFoi1eE2X+Y+yudB
        UdJahF4uShu7H6OsU6pNIdH2mriakXGydV9ATrA=
X-Google-Smtp-Source: ABdhPJwi19bzgz5V7MW7dnYyJjavTgZavChOt28VLPqtL3VrYGIVzKq5M/3CrgBSLd/1UoX52D73GzO9TQYkpo5RaMQ=
X-Received: by 2002:a19:8089:: with SMTP id b131mr786352lfd.390.1600915586739;
 Wed, 23 Sep 2020 19:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200922162542.GA18664@paulmck-ThinkPad-P72>
In-Reply-To: <20200922162542.GA18664@paulmck-ThinkPad-P72>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 23 Sep 2020 19:46:15 -0700
Message-ID: <CAADnVQJfmFjVRqJopeqy_7bHVdQ9x+i9d94Sv7Dshnh40FisTA@mail.gmail.com>
Subject: Re: [GIT PULL rcu-tasks-trace] 50x speedup for synchronize_rcu_tasks_trace()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 22, 2020 at 9:25 AM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Hello, Alexei,
>
> This pull request contains eight commits that speed up RCU Tasks Trace
> grace periods by a factor of 50, fix a few race conditions exposed
> by this speedup, and clean up a couple of minor issues.  These have
> been exposed to 0day and -next testing, and have passed well over 1,000
> hours of rcutorture testing, some of which has contained ad-hoc changes
> to further increase race probabilities.  So they should be solid!
> (Famous last words...)
>
> I would normally have sent this series up through -tip, but as we
> discussed, going up through the BFP and networking trees provides the
> needed exposure to real-world testing of these changes.  Please note
> that the first patch is already in mainline, but given identical SHA-1
> commit IDs, git should have no problem figuring this out.  I will also
> be retaining these commits in -rcu in order to continue exposing them
> to rcutorture testing, but again the identical SHA-1 commit IDs will
> make everything work out.

Pulled into bpf-next. Thanks a lot.

Also confirming 50x speedup.
Really nice to see that selftests/bpf are now fast again.

Not only all bpf developers will be running these patches now,
but the bpf CI system will be exercising them as well.
