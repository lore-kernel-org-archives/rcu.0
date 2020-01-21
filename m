Return-Path: <SRS0=d+Zk=3K=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DE9C2D0CE
	for <rcu@archiver.kernel.org>; Tue, 21 Jan 2020 14:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D202070C
	for <rcu@archiver.kernel.org>; Tue, 21 Jan 2020 14:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NgqdKcpa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbgAUOhQ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 21 Jan 2020 09:37:16 -0500
Received: from mail-qv1-f48.google.com ([209.85.219.48]:44241 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgAUOhQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 21 Jan 2020 09:37:16 -0500
Received: by mail-qv1-f48.google.com with SMTP id n8so1509655qvg.11
        for <rcu@vger.kernel.org>; Tue, 21 Jan 2020 06:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ddGV8d3t1k/dhjvmsD4e8/zjl4zKM/0x+5sMpt+zT50=;
        b=NgqdKcpa1aPPTQO1tTUlAHp4RjzoQjnanD3+o4+sHQ5by2F512X+5/qx0SCMLeAmI1
         tOpK3Rql4z6vVXTK4FoJ7kI5h/FDqkuo19VsmiAdoDXLqCGtI3N0aNjFn2cZS0mQO2CK
         QOK++ihPIxqdCp2Ni9ox0xTIFneh2HLONhLD4D9y3qBrl4v8AO5XXBjq2T+3/JBtdFJy
         tHRDu1WZ//GQinkUkUK9jwIiu8YiURfyIxO4aq3RvGJvI7fexUZiZB2yeeurSqn3zgdD
         bc+VMyhuM6C9fxSXKEAh9EID+lisH0HzY+wje/lCq9H2IgP/qOlnliXKw9FjhDlyLYW6
         ePsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ddGV8d3t1k/dhjvmsD4e8/zjl4zKM/0x+5sMpt+zT50=;
        b=JHlSQdgG5nnZbW5kmsXH+zrnwuYG3nPsWhp5MWDZogFJPRUyLc/L5ItXciq9sFuT6K
         PwmnE+5HAbpelNAKJbmFfNzh4FxwauB3x2WsfMRWkT8HlE2qgfeiKdc+5F/FPf3Ftz70
         tWpRFXDjwqIEpvbSYy3WaeWLC59C5/LSmVMIFlEhzCOrXYI0zpOOTdZRozTfPDOli7IW
         trcqIVfk5EwcNgXju1DgaXGKFquOt/hWf7n41jjAYuBj6Ji85rDNyYxP4n3aGQw1cIfK
         8yC00ugHy5adV2jyvV8SFSaWzakLCP/JwIRbrJe7rthdSTA5Jvc6CFjnkQFcz16bNhHb
         ms0A==
X-Gm-Message-State: APjAAAXMs7bXYFdG9Gq1oV9ddW2FRZMk1eyqDGBjruxvb9aNjU1L+Lid
        5GDIZsQoaAD2KIgPd4NzOPEoNoaWxGpICw==
X-Google-Smtp-Source: APXvYqyEAYvzdjpxQYSmjdTyRYfGUalNnTt6dfXtA5fj5HvDalG6KTldPIVsS/dz8/C0oDeWxibvAw==
X-Received: by 2002:a0c:c250:: with SMTP id w16mr4946957qvh.24.1579617434615;
        Tue, 21 Jan 2020 06:37:14 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o33sm20024668qta.27.2020.01.21.06.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 06:37:14 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: Boot warning at rcu_check_gp_start_stall()
Date:   Tue, 21 Jan 2020 09:37:13 -0500
Message-Id: <A230E332-07D0-40A8-A034-33ADB4BFB767@lca.pw>
References: <20200121141923.GP2935@paulmck-ThinkPad-P72>
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200121141923.GP2935@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (17C54)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Jan 21, 2020, at 9:19 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> One approach would be to boot with rcupdate.rcu_cpu_stall_timeout=3D300,
> which would allow more time.

It works for me if once that warning triggered,  give a bit information abou=
t adjusting the parameter when debugging options are on to suppress the warn=
ing due to expected long boot.

>=20
> Longer term, I could suppress this warning during boot when
> CONFIG_EFI_PGT_DUMP=3Dy, but that sounds quite specific.  Alternatively,
> I could provide a Kconfig option that suppressed this during boot
> that was selected by whatever long-running boot-time Kconfig option
> needed it.  Yet another approach would be for long-running operations
> like efi_dump_pagetable() to suppress stalls on entry and re-enable them
> upon exit.
>=20
> Thoughts?

None of the options sounds particularly better for me because there could co=
me up with other options may trigger this, memtest comes in mind, for exampl=
e. Then, it is a bit of pain to maintain of unknown.=
