Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFB9C3526D
	for <rcu@archiver.kernel.org>; Wed, 26 Jan 2022 14:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242203AbiAZOkJ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 26 Jan 2022 09:40:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242256AbiAZOkH (ORCPT
        <rfc822;rcu@vger.kernel.org>); Wed, 26 Jan 2022 09:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643208007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hqZ5S1prQcULJgjev4pMri/oRUOkdQMRX3yC6zfVtIg=;
        b=etieOdlc8OOccElA+dVKYXWYjDLcr0Sde9P6g+JEJ5QkzuShMjsnufs/BlKGnO/Kninop7
        ws20Hv+EOJAk5Iu4+9xnnkd8OlPgYPJNf2C6qND8XeJTpuJFczKDaHftCklEYl09tQvW4F
        Fgy/XqQhCmTc15WknNTMbl0RZtzn99A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-VfV2TDYhPT6XAoxomT5Nag-1; Wed, 26 Jan 2022 09:40:03 -0500
X-MC-Unique: VfV2TDYhPT6XAoxomT5Nag-1
Received: by mail-qk1-f198.google.com with SMTP id l23-20020a37f517000000b0049b8b31c76cso646109qkk.4
        for <rcu@vger.kernel.org>; Wed, 26 Jan 2022 06:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hqZ5S1prQcULJgjev4pMri/oRUOkdQMRX3yC6zfVtIg=;
        b=J0To5fbMnJaMYK4ZGaxNgQBModF5FTWPR019TAnAQtBV/sEyCB9G2aWgTC/ic5Vnyh
         tchgaYr0SRRlrU9WbEgjU1Oz/8gzWhzmABqYQawjUnytcx2bn0FUUY3gx+eK3bZIFnAp
         H+MbYALK4zZHFJ9XwcPuw6eDpFElsKn60wfy1+KJamKqBXZm43glGEhMM/C8BOCCL4St
         DR5CpPIbLuQ+JurIYXR1wMtPiuzsfsRzslHfGPK5piVtl1QQuoEMRf0I+PR/jY9J7AcE
         fHDw9U7oRDPVXU2SR6hbyH+jmJGriBvgfCkZAR6sKeNEHahLVmsGMTXpvb6WEHjD9N83
         6v7A==
X-Gm-Message-State: AOAM532UPiKUTU45EdoPhNaECWw+tohY8aLSXGQIsk45TLzvdmyykLUz
        iWshO0rcA0+/ARHoZlp7bSrwrVmrIaWC2JVFNAS8pGMXFa3D6gTc1/jFiL/rctgO3UDc3jr4awQ
        rzfjHuFxVXWTIHWnwbiNAnXgbIhNa
X-Received: by 2002:a05:6214:21ef:: with SMTP id p15mr17778185qvj.92.1643208003252;
        Wed, 26 Jan 2022 06:40:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyywkK5Wtoe5LXL+drsPdIe17bzNdMMNSpjrYtTkG1KAmitJKJB8fjznSP4WEioXe8AorW1rs112OFEWD2So/0=
X-Received: by 2002:a05:6214:21ef:: with SMTP id p15mr17778166qvj.92.1643208003014;
 Wed, 26 Jan 2022 06:40:03 -0800 (PST)
MIME-Version: 1.0
References: <202201221028.YKA8kSdm-lkp@intel.com> <CAK-6q+h_hb94J3DSXPk=E44kCxiwZ+BE3kMJe09iShRzMb=vzQ@mail.gmail.com>
 <91901e7b-7d82-116c-aaf2-c74c6a6b999c@infradead.org> <CAK-6q+j2jc3pBmbvQ-DCmxveC-UMV75SFc2nC1zwXKe9wm4YPg@mail.gmail.com>
 <20220124124530.GS1951@kadam> <CAK-6q+iZfY=FyOxJfS7cY7MqScs+nU=U3B4NnLnvcLH3fofuAg@mail.gmail.com>
 <CAK-6q+ga2zT2h4oY0=aCXFeU=oaFHbSXGzuVRptB8Hg-YKR7Gw@mail.gmail.com>
 <CAK-6q+jfA2k1TFrLqK4YN2vshgLidD=6r_CCV6df_VRFMFO7ag@mail.gmail.com>
 <20220124201417.GI4285@paulmck-ThinkPad-P17-Gen-1> <CAK-6q+gGx68Wx8mBJAdo0ygpBWPoHW+L+HD11U6UQSOjSXVP3w@mail.gmail.com>
 <20220124220628.GL4285@paulmck-ThinkPad-P17-Gen-1> <CAK-6q+j-3CWEvbFVqxd-_rc67VBZHBXPbGOo5QfGUb_KFEf_FA@mail.gmail.com>
In-Reply-To: <CAK-6q+j-3CWEvbFVqxd-_rc67VBZHBXPbGOo5QfGUb_KFEf_FA@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 26 Jan 2022 09:39:51 -0500
Message-ID: <CAK-6q+gye79SDL-zh6Uq_-oCa1gMELVi_riuqnBs-EPYfyNbow@mail.gmail.com>
Subject: Re: fs/dlm/midcomms.c:913:22: sparse: sparse: restricted __le32
 degrades to integer
To:     paulmck@kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, David Teigland <teigland@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-sparse@vger.kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On Tue, Jan 25, 2022 at 5:35 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Mon, Jan 24, 2022 at 5:14 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Jan 24, 2022 at 04:36:55PM -0500, Alexander Aring wrote:
> > > Hi,
> > >
> > > On Mon, Jan 24, 2022 at 3:23 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Mon, Jan 24, 2022 at 12:41:04PM -0500, Alexander Aring wrote:
> > > > > Hi,
> > > > >
> > > > > On Mon, Jan 24, 2022 at 12:36 PM Alexander Aring <aahringo@redhat.com> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Mon, Jan 24, 2022 at 12:21 PM Alexander Aring <aahringo@redhat.com> wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Mon, Jan 24, 2022 at 7:46 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > > > > > > >
> > > > > > > > On Sun, Jan 23, 2022 at 01:41:52PM -0500, Alexander Aring wrote:
> > > > > > > > >
> > > > > > > > > I see also:
> > > > > > > > >
> > > > > > > > > fs/dlm/midcomms.c:213:1: sparse: sparse: symbol
> > > > > > > > > '__srcu_struct_nodes_srcu' was not declared. Should it be static?
> > > > > > > > >
> > > > > > > >
> > > > > > > > Why not just do this?  (Untested.  Maybe I don't understand?)
> > > > > > > >
> > > > > > > > diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
> > > > > > > > index cb1f4351e8ba..a164089abec4 100644
> > > > > > > > --- a/include/linux/srcutree.h
> > > > > > > > +++ b/include/linux/srcutree.h
> > > > > > > > @@ -121,7 +121,7 @@ struct srcu_struct {
> > > > > > > >  #ifdef MODULE
> > > > > > > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > > > > > > >         is_static struct srcu_struct name;                              \
> > > > > > > > -       struct srcu_struct * const __srcu_struct_##name                 \
> > > > > > > > +       is_static struct srcu_struct * const __srcu_struct_##name       \
> > > > > > > >                 __section("___srcu_struct_ptrs") = &name
> > > > > > > >  #else
> > > > > > > >  # define __DEFINE_SRCU(name, is_static)                                        \
> > > > > > > >
> > > > > > >
> > > > > > > I tried it and yes it will fix the issue and introduce another one
> > > > > > > about "is_static struct srcu_struct * const __srcu_struct_##name" is
> > > > > > > unused ("-Wunused-const-variable").
> > > > > > > I added a __maybe_unused after the introduced is_static and it seems
> > > > > > > to fix the introduced issue, now it compiles and sparse is happy. I am
> > > > > > > not sure if this is the right fix?
> > > > > >
> > > > > > it is obviously unused, but it has something to do with
> > > > > > "__section("___srcu_struct_ptrs")" and during module loading it, I
> > > > > > suppose, srcu tries to access it to find whatever needs to be
> > > > > > registered?
> > > > >
> > > > > Sorry, but if this is true then it can't be declared as static... and
> > > > > we are at the beginning again.
> > > >
> > > > Welcome to my world!!!  ;-)
> > > >
> > > > More seriously, thank you for chasing this down.  But would it work to
> > > > add a declaration just before?
> > > >
> > >
> > > only if I add an "extern" in front of the declaration before, so it looks like:
> > >
> > > extern struct srcu_struct * const __srcu_struct_##name;
> > >
> > > (compile and sparse tested only)
> >
> > If that works for everyone, it seems worth persuing.
> >
> > One way to test this is as follows:
> >
> > 1.      Build a kernel with CONFIG_RCU_TORTURE_TEST=m.  Boot this and
> >         type "modprobe rcutorture torture_type=srcu".
> >
> >         If you want to stop the torture test, type "rmmod rcutorture".
> >
> >         This will test DEFINE_SRCU() for the module case.
> >
>
> I tested this case, I still need to do the 2. case. Sorry I am quite
> busy with something else, but I am still working on it.
>

I did the 2. test successful...:
"tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus --duration 3
--configs 'SRCU-N' --trust-make"
but I was required to hack it because my "qemu-system-x86_64" did not
exist, it was "/usr/libexec/qemu-kvm" (it was able to run by just
doing a symlink). I think I already cc'd the right people to report
this issue (rcu subsystem)...

I will send a patch for the export declaration soon as possible.

- Alex

