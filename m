Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07286EB64D7
	for <rcu@archiver.kernel.org>; Wed, 21 Jun 2023 01:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjFUBVG (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Jun 2023 21:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjFUBVF (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Jun 2023 21:21:05 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFB31BC;
        Tue, 20 Jun 2023 18:21:04 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-5196a728d90so7022919a12.0;
        Tue, 20 Jun 2023 18:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687310463; x=1689902463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWBVUT+cD808rcc2n6ymRH7MFq+VQPAGI3BHK3Um+Y4=;
        b=HWjJ6/5Tn/CD9kaPg91ZWHke2DU9pw/Vlb2h5ZmTmQ3auClyGF1ZDl1OhBt5TvFV8w
         8mkAkFsX1q63yTYViN+KRS7dpTY64JoEXyUTnNIsCSFuryDcOW9fsR9uK2N0vuhnYOn1
         /i6GH9l+h734t8bnW6ZWucoCrvyVilZOU0jhau74NQrm6AY34IjFOT30zYDvxFRy3Vym
         dk8eDEzqFLexQvT24ghUQ12/pDdzheDbaYjP+RbL8939BOVGsJFQj/dlzk0jOaM8GMJC
         XvW5uwE5X2fwwyZuBAc1F8Y0CgllLfQFK+LMw6fwkoTcrbowZkOMzxJxRSs91DWriU8m
         ivYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687310463; x=1689902463;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWBVUT+cD808rcc2n6ymRH7MFq+VQPAGI3BHK3Um+Y4=;
        b=Xr+lIVK3mJjR4IZ1vtAl/KGCuVufd82Gv10j43VVw7rXoCZHCOs68KvPABQHR2sVOg
         26DEkTQdPo77hETTn6fk3UPh9kDqSKIK01Pfj0mONP5CKabX2TplS3uvcB8Rv0WaDoB4
         qz0htUCe6bxsE6qNUtQzIiVZlWk5XzKdZxz5+4szKZCCkU7tlU+mdLYmAUNHDiQ4NNm9
         zU7Po+3/xgtt7q+ztRsWvaKVeCt+iKatLTE+TdE1V3KUOON7wR7MnSQ6wxMF4BFy577U
         dPGLp2jpUy5s/5nyHa4T996W/RuYZxBRZ4/O+YG3d+dO2H9I6z49EESTBa5wwBtEuM/A
         hsbA==
X-Gm-Message-State: AC+VfDx70o3YcnpDJ2ofUqH1imohfSXhVWR85u716qcyfHtavc2SfTP9
        m1/T9tpKIsdGiWi7g+77C0b7QgU6g+D3KdS6OSo=
X-Google-Smtp-Source: ACHHUZ4SmQfz0sFH/Om0wBNV8pm0qEHWAIM4MuAaODCiUcceoVayHDfwrii3CF679IA2jbvgzNW1ZsWbL0/CVALccFE=
X-Received: by 2002:a05:6402:124d:b0:514:9bb7:d0bd with SMTP id
 l13-20020a056402124d00b005149bb7d0bdmr10019012edw.24.1687310463066; Tue, 20
 Jun 2023 18:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230619143231.222536-1-houtao@huaweicloud.com>
 <20230619143231.222536-3-houtao@huaweicloud.com> <CAADnVQLPpnTT2W1Ev6Q5g2h2qk6aoFa9uFsuc7Q6Xb36e4YV3w@mail.gmail.com>
 <88a55864-d279-d004-e134-fa9a57c37bc7@huaweicloud.com>
In-Reply-To: <88a55864-d279-d004-e134-fa9a57c37bc7@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 20 Jun 2023 18:20:51 -0700
Message-ID: <CAADnVQ+xLcb3eb1xTnVdv_5MnG8UMD1hOor8-exVcqKsvfwD_A@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 2/2] bpf: Call rcu_momentary_dyntick_idle()
 in task work periodically
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Jun 20, 2023 at 6:07=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 6/21/2023 12:15 AM, Alexei Starovoitov wrote:
> > On Mon, Jun 19, 2023 at 7:00=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> +static void bpf_rcu_gp_acc_work(struct callback_head *head)
> >> +{
> >> +       struct bpf_rcu_gp_acc_ctx *ctx =3D container_of(head, struct b=
pf_rcu_gp_acc_ctx, work);
> >> +
> >> +       local_irq_disable();
> >> +       rcu_momentary_dyntick_idle();
> >> +       local_irq_enable();
> > We discussed this with Paul off-line and decided to go a different rout=
e.
> "A different route" means the method used to reduce the memory footprint
> is different or the method to do reuse-after-rcu-gp is different ?

Pretty much everything is different.

> > Paul prepared a patch for us to expose rcu_request_urgent_qs_task().
> > I'll be sending the series later this week.
> Do you plan to take over the reuse-after-rcu-gp patchset ?

I took a different approach.
It will be easier to discuss when I post patches.
Hopefully later today or tomorrow.

> I did a quick test, it showed that the memory footprint is smaller and
> the performance is similar when using rcu_request_urgent_qs_task()
> instead of rcu_momentary_dyntick_idle().

Right. I saw a similar effect as well.
My understanding is that rcu_momentary_dyntick_idle() is a heavier mechanis=
m
and absolutely should not be used while holding rcu_read_lock().
So calling from irq_work is not ok.
Only kworker, as you did, is ok from safety pov.
Still not recommended in general. Hence rcu_request_urgent_qs_task.
