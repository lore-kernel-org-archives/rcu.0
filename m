Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C891C6FD18
	for <rcu@archiver.kernel.org>; Tue, 25 Apr 2023 16:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbjDYQdH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjDYQdH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Apr 2023 12:33:07 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B74FCC08
        for <rcu@vger.kernel.org>; Tue, 25 Apr 2023 09:33:05 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2a8c30ac7e3so55060321fa.1
        for <rcu@vger.kernel.org>; Tue, 25 Apr 2023 09:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crave-io.20221208.gappssmtp.com; s=20221208; t=1682440383; x=1685032383;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2Rac/m/Y+ztLD9bbJxV7ApwvMbYAdfnb0KmgsQRfHY=;
        b=Vj6pm4p5yAPxnoo4rbsnOecNKBt3DdGr3U1Ei8Qq8daj4Y4p43+GL7JopOJVBodxTs
         jiQfapA7l2y/ovF5+zmzilBAb7f36JU8HNNQvgzlz4mfM9P341M9F1qa6bjdP70vOlz4
         Di6uYPUYRE2erbwM6afXYyU8CbdLyMTwE8APpIU38UjORGtSiID5GZQrzYe9V7guEdir
         B6TRDt6kf0e/ygGg9pQsnQA8QEZEYoufiScjlqmw//jBwRrX4CWifoV9TzlmgyNQyveI
         PCC1ztvHl5jgAd+ATjqth4wIT96XJOl8BUqIe7Pq93f0frGOyxAnJVE6rCRGJ2gv9iyS
         XpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682440383; x=1685032383;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s2Rac/m/Y+ztLD9bbJxV7ApwvMbYAdfnb0KmgsQRfHY=;
        b=YhB4M1Y61WV0bpdPNUlYnOSn0vtgImt1FksEJKlY78t82mpum4I68uzO61X+F4hGYb
         WwtVCcqUlNvyrJMTTznh10Pw8jkVzr5xS+TSvipYtVVjO9PlHQmxw+64absQzwS6k1dS
         A0pdsnp7JO9qpUNlx9UwN6DJS2LLWTeGJr3K9CE7VTRD11U3ykbQmSnDJ2zy2tvl08Tk
         hlNC+l1S7oo36fKl2nsmmjRrDgR7aoTey1OeS2y0mspcMi1AWgiHKyZiRcBINvcXpyas
         iaIlorwetRClJVYDwPsFDLojXWanQSDjfAez+PGGtz2dGR/4RCBqjvZ/Q1TlLTagJT/G
         nNKg==
X-Gm-Message-State: AAQBX9caejzRpfQPnS3YPXS98bN8uizOUv0IRhI5c0EGSLq0adm9jujn
        BdGXJfRS6ooKifvROOCIAW8jm99bUva2svDeUgSst6qeSGs+Ui6yQV0=
X-Google-Smtp-Source: AKy350anYh3/vReXRKwC+LLBBE3Cc3lVfwcvsyucq0nk3+QlE7ExNOyaCaFGXSZOe2nCQTGu2EikNdmy6LanIOGD/FE=
X-Received: by 2002:ac2:4576:0:b0:4eb:1e87:b1fe with SMTP id
 k22-20020ac24576000000b004eb1e87b1femr4891326lfm.58.1682440383096; Tue, 25
 Apr 2023 09:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHOZ0eADVgEPVEv-rBrF=E11v-4S4xnY1rej=MytLtSFperMFw@mail.gmail.com>
 <ZEclEg+1qeL4HkBm@boqun-archlinux>
In-Reply-To: <ZEclEg+1qeL4HkBm@boqun-archlinux>
From:   Yuvraaj Kelkar <uv@crave.io>
Date:   Tue, 25 Apr 2023 09:32:51 -0700
Message-ID: <CAHOZ0eCRZunDbX3YOy++31xrq60y3_ge=JJz5mbHAy+k6LfchQ@mail.gmail.com>
Subject: Re: RCU Torture test failed at git commit 61d325dcbc05d8fef88110d35
To:     rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

I've been trying to attach logs to this email since yesterday, but the
mailing list keeps rejecting my attempts.
I've uploaded all the logs to my Google Drive:
https://drive.google.com/drive/folders/1giTWAVnu-rmfEsb-vLQJSxtg6wmHnzeG?us=
p=3Dsharing

I hope at least this link will be allowed by the system.

Thanks,
-Uv

On Mon, Apr 24, 2023 at 5:56=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Apr 24, 2023 at 05:00:25PM -0700, Yuvraaj Kelkar wrote:
> > Hi RCU folks,
> >
> > We have a RCU torture test set up that has just reported a failure at
> > commit ID 61d325dcbc05d8fef88110d35 on the Linux kernel.
> > The command was: ./kvm.sh --cpus 102
> > Logs are attached.
>
> Could you also share the TREE03 log:
>
>         /tmp/src/linux/tools/testing/selftests/rcutorture/res/2023.04.24-=
22.17.41/TREE03/console.log
>
> the build log basically said there is something wrong in that log.
>
> Regards,
> Boqun
