Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8777EC6FA82
	for <rcu@archiver.kernel.org>; Tue, 20 Sep 2022 22:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiITWlD (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Sep 2022 18:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiITWlC (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Sep 2022 18:41:02 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6336745D
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 15:41:00 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r134so3624619iod.8
        for <rcu@vger.kernel.org>; Tue, 20 Sep 2022 15:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6xGBzkpzGtXA1cjIBFLbZOyiRrKPbb8dP7Jm7cWwoU4=;
        b=QeHfaupcfP9JN2fNXUVDO6uuFa1JN9ZMz+/MGB8MoSD5CqNkEn0hnZS+MSfFWfJ/VZ
         jusyycTcxwpiVryG8UDj86SdtQdfp3Ivi1TTmxvx7x/jxLhBXpb2iFg27pQp3N69OMqQ
         TWgjdVvegb3diNRRcnFRN4LONfmVLwgJnlgvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6xGBzkpzGtXA1cjIBFLbZOyiRrKPbb8dP7Jm7cWwoU4=;
        b=0c1WUGuCNpxhb7DRDjAl1Gi0N28F1mhTa2jEeSpuKVkduOVfeTWfA3//YI2vEwLy6m
         lji2sl7zQ6AnbFeXBOm969POeJQOVm5vJQHnn9xpuSe6b3zRLZNiR64EpWIm2uLeAMFk
         LeN+V/XEl5AzhXnUJ8GiyMmdrXJ0gOEHDjAEcHyMbzSLuUOIUlnPHwqpWCSzqyKn3yuu
         aOVq0Vf1JvZe3U5dTCSgOt4mg32+9X3YQFj8V+OJoL8Xz5K1mUUSh+Okzq1d8IPFuByA
         H869K8nV6zv4ImADonYYlZ70sxpp8YtmiYyzSV+iDY5qCuEn9RZ8+VjujuQ/R8wYep1t
         SiSw==
X-Gm-Message-State: ACrzQf3dALbWM6+Q3nwNTx5AowTDlPuWdyMA7zLEID3xyqR/d6p2i/rj
        PAM7VTwW+hAk/vhI5PkBe9QA/VHI9s7x2L9aeKEyKg==
X-Google-Smtp-Source: AMsMyM4dkC2p0a8UXOJqyu6wOrOG1tol/umX7gScIifLfAbNRqDMJY44jAQLQFEUz+jQDd+LtM76m162a9SnPm4Smok=
X-Received: by 2002:a05:6638:379e:b0:35a:6503:453c with SMTP id
 w30-20020a056638379e00b0035a6503453cmr11833002jal.118.1663713659966; Tue, 20
 Sep 2022 15:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXW_YQGPwkTQjxAb5p4OOhJkMA-L93JNTsa-WaXs0Ts7=Oakw@mail.gmail.com>
 <20220919223211.GJ4196@paulmck-ThinkPad-P17-Gen-1> <f061b798-e6f6-1523-52c3-12fe7966f809@joelfernandes.org>
 <a2882e80-1723-9004-f67a-cd8332aa701d@joelfernandes.org> <d72808e1-fc27-f158-37b7-ef23c23e74c1@joelfernandes.org>
 <CAEXW_YRsp4HqwAPaDq9VYRptwgdcp7mPJjRH1msE42gzGajBjQ@mail.gmail.com>
 <20220920123208.GL4196@paulmck-ThinkPad-P17-Gen-1> <Yyn+qSZiYI02WxOv@google.com>
 <20220920190306.GR4196@paulmck-ThinkPad-P17-Gen-1> <CAEXW_YThgajt5C86GoEn_N8ywMByfO_4Ni0CHB85tm1yBG+tsg@mail.gmail.com>
 <20220920223505.GV4196@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220920223505.GV4196@paulmck-ThinkPad-P17-Gen-1>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 20 Sep 2022 18:40:48 -0400
Message-ID: <CAEXW_YTFiw53e=SJ+08Ks2gmfYme4uvE=aN=1GQFSx_uVDh3KA@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] Implement call_rcu_lazy() and miscellaneous fixes
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Kadam, Rushikesh S" <rushikesh.s.kadam@intel.com>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Sep 20, 2022 at 6:35 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Sep 20, 2022 at 06:27:52PM -0400, Joel Fernandes wrote:
> > On Tue, Sep 20, 2022 at 3:03 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > [...]
> > One question - call_rcu_expedited() just means "use regular non lazy
> > rcu", not "use expedited grace periods" right? In this case, is it
> > better to call it call_rcu_fast() or call_rcu_nonlazy() to avoid
> > conflicts with the "expedited" terminology in the
> > synchronize_{s,}rcu_expedited() APIs?
>
> I agree that call_rcu_expedited() is likely to cause confusion.
> The call_rcu_fast() is nice and short, but the result really is not all
> that fast.  The call_rcu_nonlazy() sounds good, but I am sure that as
> usual there will be no shortage of bikeshedders.  ;-)

call_rcu_tglx() and then we can Thomas's tags :-D Jk.

call_rcu_faster() since it is faster than regular call_rcu()

call_rcu_hurry_up_already()  , likely a NAK but sounds cool :-D

Jokes aside,
call_rcu_flush() - because the CBs are not batched like regular call_rcu() ?

thanks,

- Joel
