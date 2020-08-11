Return-Path: <SRS0=EzCL=BV=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D50C433DF
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 18:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F862076C
	for <rcu@archiver.kernel.org>; Tue, 11 Aug 2020 18:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iiA8txfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgHKS2Q (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHKS2Q (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 11 Aug 2020 14:28:16 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D39C06174A
        for <rcu@vger.kernel.org>; Tue, 11 Aug 2020 11:28:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k20so3757651wmi.5
        for <rcu@vger.kernel.org>; Tue, 11 Aug 2020 11:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nazLfjeHIm0CIJ86cp1U5OrCy+yCaz0xLbKkAoevkG4=;
        b=iiA8txfUaJMI1jTicmhP2KFThzv4LMSTKgw/wYwwTbEYQt/AQ1C9o4n60LjavxkRkV
         TQg0eLGyfDVH7nVGMl+VbyIm6jueILkIqbC/ZzC/MtZOLNbbdo44OS1QJVp3nDF9nc2V
         cbT6btxCXWc9BJ8YoF1fn4YE070zhDeNDv2thif3XZFvIDjjZuRB1NTkbFDrkDqyYhnA
         ED7uQ9DwA52Qc14KCQGVVxzDK95on5z2t1Jgz11mMMCQZY0XTl0qj75/PR0ihxzEm74+
         gUddiu9ZVxuikkXNDwgcVH41GVQa8kHBQfrycMwIbvkPFmrBdEe/wYyroimTiKXvolRF
         09fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nazLfjeHIm0CIJ86cp1U5OrCy+yCaz0xLbKkAoevkG4=;
        b=ZFigtClD85KvZZqxYkiKn8E6kfkEAXnq05xJguPAICgzKM+cm7hwPrDXBMBJuwFUH4
         KOu4WS0xTTZ+kjBW+WMILqd3YDajTbKmMNt5JCDKJam67CagtG6PTl3xV4kxyXbO/x8X
         KMJPX61dR8dpgj2LEWl9aokK28p+LZkbVMza+5JVkr8oKtzAvTkJrKXo0AEH274DJ5I9
         UgVpoTEDecOyjMaCyb4gAGewPaoOqAp5lCKr0pCZTCtgzhTULSTwFQ2a/jvf2/04jAwM
         4ShSTgBRnBNcx+U+5xdiM8fp8rOyibIS2P4UeplfIBpLB0/358vmTVNvmSgQ6h3BDRX+
         dkjg==
X-Gm-Message-State: AOAM533i6GasefUz5pY9CoXygrdNoe5XzyrvZfwQqg1s5EiqiKMXSmi+
        Gd5LA9myKwdAS21c5Fmhx68h474Mh5zWiDyiZN0f
X-Google-Smtp-Source: ABdhPJz+PvMify1pGrVbQeyMI2tNhi9anNMz9m9stI84KLSO5Q8qG2GVYs3WoNjjPlMtX2swM1hMfyZbYhu3BZzc8ZQ=
X-Received: by 2002:a7b:c765:: with SMTP id x5mr4886729wmk.14.1597170494689;
 Tue, 11 Aug 2020 11:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Sh73MJhqs7PBk6OV2AhzVjYvE1foUQUnwP5DwWR44LHZRZ9w@mail.gmail.com>
 <58be64c5-9ae4-95ff-629e-f55e47ff020b@gmail.com> <CA+Sh73NeNr+UNZYDfD1nHUXCY-P8mT1vJdm0cEY4MPwo_0PtzQ@mail.gmail.com>
 <CAEXW_YSSL5+_DjtrYpFp35kGrem782nBF6HuVbgWJ_H3=jeX4A@mail.gmail.com>
 <20200807222015.GZ4295@paulmck-ThinkPad-P72> <20200810200859.GF2865655@google.com>
 <20200810202813.GP4295@paulmck-ThinkPad-P72> <CAMDZJNWrPf8AkZE8496g6v5GXvLUbQboXeAhHy=1U1Qhemo8bA@mail.gmail.com>
 <CAM_iQpXBHSYdqb8Q3ifG8uwa1YfJmGBexHC2BusRoshU0M5X5g@mail.gmail.com>
 <CAMDZJNU5Cpkcrn5sy=7u_vTGcdMjDfCqzSCJ0WLk-3M5RROh=Q@mail.gmail.com>
 <CAM_iQpVoHtQn07j9wHp7Qj3XkU8SYFdYzaexx6jeBH5mqYNw6A@mail.gmail.com> <CAMDZJNX2G2dOkqFv52ztBMM5CZCY4b0rSz-knv4GY2JP9kbDmg@mail.gmail.com>
In-Reply-To: <CAMDZJNX2G2dOkqFv52ztBMM5CZCY4b0rSz-knv4GY2JP9kbDmg@mail.gmail.com>
From:   =?UTF-8?B?Sm9oYW4gS27DtsO2cw==?= <jknoos@google.com>
Date:   Tue, 11 Aug 2020 11:28:03 -0700
Message-ID: <CA+Sh73M=Wwf=tzcb7WeSbLFzaARAvgCC1CFaZKKEA5kr17_BAw@mail.gmail.com>
Subject: Re: [ovs-discuss] Double free in recent kernels after memleak fix
To:     Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Gregory Rose <gvrose8192@gmail.com>,
        bugs <bugs@openvswitch.org>, Netdev <netdev@vger.kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 10, 2020 at 10:59 PM Tonghao Zhang <xiangxia.m.yue@gmail.com> wrote:
>
> On Tue, Aug 11, 2020 at 12:08 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > On Mon, Aug 10, 2020 at 8:27 PM Tonghao Zhang <xiangxia.m.yue@gmail.com> wrote:
> > >
> > > On Tue, Aug 11, 2020 at 10:24 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> > > >
> > > > On Mon, Aug 10, 2020 at 6:16 PM Tonghao Zhang <xiangxia.m.yue@gmail.com> wrote:
> > > > > Hi all, I send a patch to fix this. The rcu warnings disappear. I
> > > > > don't reproduce the double free issue.
> > > > > But I guess this patch may address this issue.
> > > > >
> > > > > http://patchwork.ozlabs.org/project/netdev/patch/20200811011001.75690-1-xiangxia.m.yue@gmail.com/
> > > >
> > > > I don't see how your patch address the double-free, as we still
> > > > free mask array twice after your patch: once in tbl_mask_array_realloc()
> > > > and once in ovs_flow_tbl_destroy().
> > > Hi Cong.
> > > Before my patch, we use the ovsl_dereference
> > > (rcu_dereference_protected) in the rcu callback.
> > > ovs_flow_tbl_destroy
> > > ->table_instance_destroy
> > > ->table_instance_flow_free
> > > ->flow_mask_remove
> > > ASSERT_OVSL(will print warning)
> > > ->tbl_mask_array_del_mask
> > > ovsl_dereference(rcu usage warning)
> > >
> >
> > I understand how your patch addresses the RCU annotation issue,
> > which is different from double-free.
> >
> >
> > > so we should invoke the table_instance_destroy or others under
> > > ovs_lock to avoid (ASSERT_OVSL and rcu usage warning).
> >
> > Of course... I never doubt it.
> >
> >
> > > with this patch, we reallocate the mask_array under ovs_lock, and free
> > > it in the rcu callback. Without it, we  reallocate and free it in the
> > > rcu callback.
> > > I think we may fix it with this patch.
> >
> > Does it matter which context tbl_mask_array_realloc() is called?
> > Even with ovs_lock, we can still double free:
> >
> > ovs_lock()
> > tbl_mask_array_realloc()
> >  => call_rcu(&old->rcu, mask_array_rcu_cb);
> > ovs_unlock()
> > ...
> > ovs_flow_tbl_destroy()
> >  => call_rcu(&old->rcu, mask_array_rcu_cb);
> >
> > So still twice, right? To fix the double-free, we have to eliminate one
> > of them, don't we? ;)
> No
> Without my patch: in rcu callback:
> ovs_flow_tbl_destroy
> ->call_rcu(&ma->rcu, mask_array_rcu_cb);
> ->table_instance_destroy
> ->tbl_mask_array_realloc(Shrink the mask array if necessary)
> ->call_rcu(&old->rcu, mask_array_rcu_cb);
>
> With the patch:
> ovs_lock
> table_instance_flow_flush (free the flow)
> tbl_mask_array_realloc(shrink the mask array if necessary, will free
> mask_array in rcu(mask_array_rcu_cb) and rcu_assign_pointer new
> mask_array)
> ovs_unlock
>
> in rcu callback:
> ovs_flow_tbl_destroy
> call_rcu(&ma->rcu, mask_array_rcu_cb);(that is new mask_array)
>
> >
> > >
> > > > Have you tried my patch which is supposed to address this double-free?
> > > I don't reproduce it. but your patch does not avoid ruc usage warning
> > > and ASSERT_OVSL.
> >
> > Sure, I never intend to fix anything else but double-free. The $subject is
> > about double free, I double checked. ;)
> >
> > Thanks.
>
>
>
> --
> Best regards, Tonghao

Cong and Tonghao, thanks for your patches. I cannot repro the double
free with either of them, and the "suspicious RCU usage" and the
ASSERT_OVSL warnings are also gone with Tonghao's patch.

Tonghao, from your sequence above it looks like it should fix the
https://elixir.bootlin.com/linux/v5.5.17/source/kernel/rcu/tree.c#L2239
warning, correct?
