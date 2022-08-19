Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A42BC28B2B
	for <rcu@archiver.kernel.org>; Fri, 19 Aug 2022 18:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349919AbiHSSRq (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 19 Aug 2022 14:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349792AbiHSSRp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 19 Aug 2022 14:17:45 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48548CE12
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 11:17:44 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id p184so3893582iod.6
        for <rcu@vger.kernel.org>; Fri, 19 Aug 2022 11:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=0N+aGlpvF5n2BpgF0PUXQA/veXWFFa+QNzcAxMqjXwY=;
        b=Bfi1w1xU6UkNJragDtxZi5Zg/Lw+a7nqgU6c598ghTQUesRRoZxA5lXbi0AL380OlK
         a/Ckw/Z86Y82FXXOyduEcphMLQjXNWaqULg05UUm0LLjdNRo//VF3S+2omqQBUPEc2iG
         IKAy2RJ9lbBcVAxxfQhQw7d2elim+10uw740E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0N+aGlpvF5n2BpgF0PUXQA/veXWFFa+QNzcAxMqjXwY=;
        b=sz7/8hTGWlym8acNCkMw0yJnU39dDZuro1VG8c+KFEywrxUeIvuCJ4k5+i08YmTjrO
         BjeXSBlQX8oxg0qChHhCkLgXe0xVx2+K4jaQ4kkKAk2cKHISjPOntiNf0YjCFWp3WPeQ
         4RrDKrzyu3UFxEsv3T+Hau+Z4IiDc00lXt2Ndi9h46+C6ubXEATvBr9NcksmOY4hquHH
         QivyPApSDKLigXcYytwhxa/Fa8MoRFRgZGYFO2ZBur5IVnrPn7Mo+Fof2HHI3/Fl6tAJ
         DzEjRMo2HbKNpx+jrNFOD0Rs4LiVaYrA+QxlcqCaXMTWLFxbQwHr8tQAcTFRD0uM8gnA
         P3lw==
X-Gm-Message-State: ACgBeo0HuPezA3H5vIEreJ7C5n+80tO97sGJtYhp9THnswYYIpn/qeDM
        EmEfSzqfzDkY/RClIW4rsdPNUD4F708aYx2wuQ/0ig==
X-Google-Smtp-Source: AA6agR6Nn5dT2qqMts4wTltvlhnHOo8EQ1ViTBNvWlPoB1Xcuqhzr01b82bdA7VmWpDZmKiRy/HAk+JJACwdOCVReA8=
X-Received: by 2002:a05:6638:4982:b0:342:39e0:1d44 with SMTP id
 cv2-20020a056638498200b0034239e01d44mr3908539jab.213.1660933063633; Fri, 19
 Aug 2022 11:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220809034517.3867176-1-joel@joelfernandes.org>
 <20220809034517.3867176-5-joel@joelfernandes.org> <CAEXW_YQuGga9Eivq4G6o1XjvPn-nMMDiM8FOY6HXJTMzwv1Emg@mail.gmail.com>
 <CAEXW_YQOXBRwCLZXjspXttGkNhbJK3HGVDuYj5TcYD=Xj1cK0A@mail.gmail.com>
 <CAEXW_YT3VnK5KJTbyXdCzs8j4jw9XFTSCF4Dt9QwLPtkPSb1tA@mail.gmail.com>
 <20220819023550.GN2125313@paulmck-ThinkPad-P17-Gen-1> <4deb7354-bac7-b530-47ba-54cf50cfce58@joelfernandes.org>
 <2d56e4ad-7d6e-2abb-461f-15f20128d42b@joelfernandes.org> <20220819171249.GP2125313@paulmck-ThinkPad-P17-Gen-1>
 <fa8b7857-b9fd-72ad-36a7-8b09e4472816@joelfernandes.org>
In-Reply-To: <fa8b7857-b9fd-72ad-36a7-8b09e4472816@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 19 Aug 2022 14:17:32 -0400
Message-ID: <CAEXW_YTxtfbbQ_rOiSbu62GpDPBDFpfWrNBef06MAkYPybNJ2A@mail.gmail.com>
Subject: Re: [PATCH v3 resend 4/6] fs: Move call_rcu() to call_rcu_lazy() in
 some paths
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Aug 19, 2022 at 2:14 PM Joel Fernandes <joel@joelfernandes.org> wrote:
[..]
> >> Things are much better with the following change. However, this brings
> >> me to a question about lock-contention based or any deferring and boot time.
> >>
> >> If you have a path like selinux doing a synchronize_rcu(), shouldn't we
> >> skip the jiffie waiting for the bypass timer? Otherwise things
> >> synchronously waiting will slow down more than usual. Maybe bypassing
> >> should not be done for any case until boot up is done. I'm curious to
> >> see if that improves boot time.
> >
> > Why not simply disable laziness at boot time and enable it only after
> > booting is complete?  The exiting rcupdate.rcu_normal_after_boot kernel
> > boot parameter uses a similar scheme.
>
> That sounds like the right thing to good, but unfortunately it wont help
> this problem. The boot time issue happens after init has started. So the
> OS is still "booting" even though the kernel has.
>
> Also the problem can happen after boot as well, like if RCU
> lazy/non-lazy callbacks come back to back quickly, or so.
>
> But yes nonetheless, I can see the value of disabling it till the
> in-kernel boot completets.

My mail client is acting weird. I meant to add to this, I wonder if
there is a way other subsystems detect when userspace boots using some
heuristic?

Thanks,

 -  Joel
