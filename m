Return-Path: <SRS0=/SR9=3F=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1889C33CB1
	for <rcu@archiver.kernel.org>; Thu, 16 Jan 2020 11:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9D72073A
	for <rcu@archiver.kernel.org>; Thu, 16 Jan 2020 11:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgAPLT6 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 16 Jan 2020 06:19:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51330 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgAPLT6 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 16 Jan 2020 06:19:58 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1is3Bq-0005DA-Jz; Thu, 16 Jan 2020 12:19:54 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 3F1F8101B66; Thu, 16 Jan 2020 12:19:54 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Sasha Levin <sashal@kernel.org>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rcu@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/2] kernel: set taint flag 'L' at any kind of lockup
In-Reply-To: <157503370645.8187.6335564487789994134.stgit@buzz>
References: <157503370645.8187.6335564487789994134.stgit@buzz>
Date:   Thu, 16 Jan 2020 12:19:54 +0100
Message-ID: <87eevzwsv9.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Konstantin Khlebnikov <khlebnikov@yandex-team.ru> writes:
> Any lockup or stall notifies about unexpected lack of progress.
> It's better to know about them for further problem investigations.
>
> Right now only softlockup has own taint flag. Let's generalize it.
>
> This patch renames TAINT_SOFTLOCKUP into TAINT_LOCKUP at sets it for:

Please search 'This patch' in Documentation/process/submitting-patches.rst

> - softlockup
> - hardlockup
> - RCU stalls
> - stuck in workqueues
> - detected task hung

This does too many things at once and wants to be split in pieces:

  1) Change the TAINT flag and update documentation

  2) Add the tainting to the places which are not yet covered

Thanks,

        tglx
