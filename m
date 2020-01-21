Return-Path: <SRS0=d+Zk=3K=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD667C2D0DB
	for <rcu@archiver.kernel.org>; Tue, 21 Jan 2020 19:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F7121835
	for <rcu@archiver.kernel.org>; Tue, 21 Jan 2020 19:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Sn/YEVab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgAUTJK (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:09:10 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]:39360 "EHLO
        mail-qv1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbgAUTJJ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Jan 2020 14:09:09 -0500
Received: by mail-qv1-f53.google.com with SMTP id y8so2004429qvk.6
        for <rcu@vger.kernel.org>; Tue, 21 Jan 2020 11:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OkhQvHS8jVFYyzSdwlzdra0fHXrxQRAP81m6ftm1DPo=;
        b=Sn/YEVabYrSO+1xwPBsT1wsX23V+Ss+TkR6cRQZP+XHVFao+nmyPXPSBpe/ZD9Hv1s
         8fT4YVNncAUSpX3hsTV4sPnOFDNe5YnLPXCBUx+ZT6AcTnOrNg2MXhwaINSUxKT8q5Eu
         e+Ef0VCok7XicUl/z3tMEfsPixu8nZ9ghOIu/s8czG5H0BWyyqYL7qnbOOa6SdadIOp4
         b2E5vJtYRt49QoI0MCXJP3m+XeqeFLt6yfK7RESy7Mvr4Z+pqb0c50hyZwhUpsnWDN2W
         RBF7c5xznWOdZ47b64d1IEqExfHkY9Bj2S/ags3M0gnNrLRozyIC2yUCS5sbYK24HJxj
         xHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OkhQvHS8jVFYyzSdwlzdra0fHXrxQRAP81m6ftm1DPo=;
        b=YRSY7J6vf0O8nh7OH8wH3TTEF/ib/ToV/2GJ4B/FN9QPVVJW+r1AFSjYYaBvoCqz6h
         AmANzdb61u3tAXLc5DQx6xrUKN6Ai19RhAfyq01NP10AXbP/ElVCRF0Cg2X/+3EeNLb7
         dYz45EDSdtnNKxp/6M1NgZMe7aqd1F+cGCLFX+rUG2utYrNI6Su6IuPUJ9qV4qysl+fU
         v0tYAcIAZA3Ge+gXAoc4YPctW9tSVy9kKB8gau5+ZxG941rQNKDkHDx9cXQgrfBztF4p
         mOFaIYNWs7C4926fx6NwSZlA2mv/YW/Ac1gpOXqXLC72/K5MWxrJHQWvW2BOZMkAumRv
         1zJA==
X-Gm-Message-State: APjAAAWG/gmfTSY77xwk2LxTsc7VTktRovw4ax0z9TxKXMIzliaJTfdr
        yPU7bt4EE7INaBOOPAx6jsxCXA==
X-Google-Smtp-Source: APXvYqw0QDyCQ435rTnlGbW4snzDWcupFjquDZIIGXvun07tKi7Z0gmG+0nbTGb34WOwp8jsY+XRhA==
X-Received: by 2002:a0c:cd8e:: with SMTP id v14mr6423089qvm.182.1579633747273;
        Tue, 21 Jan 2020 11:09:07 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v24sm19554611qtq.14.2020.01.21.11.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2020 11:09:06 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: Boot warning at rcu_check_gp_start_stall()
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200121161533.GT2935@paulmck-ThinkPad-P72>
Date:   Tue, 21 Jan 2020 14:09:05 -0500
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6A6B0325-64C4-4470-91B4-37104CF8DA1A@lca.pw>
References: <20200121141923.GP2935@paulmck-ThinkPad-P72>
 <A230E332-07D0-40A8-A034-33ADB4BFB767@lca.pw>
 <20200121161533.GT2935@paulmck-ThinkPad-P72>
To:     "Paul E. McKenney" <paulmck@kernel.org>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Jan 21, 2020, at 11:15 AM, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>=20
> On Tue, Jan 21, 2020 at 09:37:13AM -0500, Qian Cai wrote:
>>=20
>>=20
>>> On Jan 21, 2020, at 9:19 AM, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>>>=20
>>> One approach would be to boot with =
rcupdate.rcu_cpu_stall_timeout=3D300,
>>> which would allow more time.
>>=20
>> It works for me if once that warning triggered,  give a bit =
information about adjusting the parameter when debugging options are on =
to suppress the warning due to expected long boot.
>=20
> Indeed.  300 seconds as shown above is currently the maximum, but
> please let me know if it needs to be increased.  This module parameter
> is writable after boot via sysfs, so maybe that could be part of the
> workaround.
>=20
>>> Longer term, I could suppress this warning during boot when
>>> CONFIG_EFI_PGT_DUMP=3Dy, but that sounds quite specific.  =
Alternatively,
>>> I could provide a Kconfig option that suppressed this during boot
>>> that was selected by whatever long-running boot-time Kconfig option
>>> needed it.  Yet another approach would be for long-running =
operations
>>> like efi_dump_pagetable() to suppress stalls on entry and re-enable =
them
>>> upon exit.
>>>=20
>>> Thoughts?
>>=20
>> None of the options sounds particularly better for me because there =
could come up with other options may trigger this, memtest comes in =
mind, for example. Then, it is a bit of pain to maintain of unknown.
>=20
> I was afraid of that.  ;-)
>=20
> Could you please send me the full dmesg up to that point?  No =
promises,
> but it might well be that I can make some broad-spectrum adjustment
> within RCU.  Only one way to find out=E2=80=A6

https://cailca.github.io/files/dmesg.txt

