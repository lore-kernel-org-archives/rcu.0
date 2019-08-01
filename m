Return-Path: <SRS0=/vWc=V5=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CF1C433FF
	for <rcu@archiver.kernel.org>; Thu,  1 Aug 2019 18:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CBA62080C
	for <rcu@archiver.kernel.org>; Thu,  1 Aug 2019 18:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="etmtCIar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730581AbfHASiR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:38:17 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44108 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbfHASiQ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Aug 2019 14:38:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so70363947ljc.11
        for <rcu@vger.kernel.org>; Thu, 01 Aug 2019 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRm0VZw0+vdPfuqKlyvMVmBBDH4QPYqnMrDhSJUTODc=;
        b=etmtCIarLpwD+He3nYQPx7WMrIItIUgF4WO27z/NtvDv+MRz2APxEgRTZD2hkOpuve
         3yc4ZvTFru2Y3nncQvXfwcWxMWeDmXilO7ffYdXfaCqTyZTN7zW6y4Ot5jBEzkRDwF3p
         Ke+I+G5YvZN2IekOO1h+1NM69qLjvXzIEFqa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRm0VZw0+vdPfuqKlyvMVmBBDH4QPYqnMrDhSJUTODc=;
        b=Fx+pYBov0+xN3jM7QjyqT9lLUeOB2B/mIA6GZ1KCHA/SXBZUV1Y3P2Zbd6saYRT32g
         Efmuj3Dp8Cvowjz3mBCqT4GHQWPGyBSUl34j8XxzpfQUwopmkMPpeHnVU/VCFCyjZT8z
         YlRDY9MEHWlsOlDt7Zfgwp2Smj4CAAVnxWz8WlvLnvwyhNl1Fs5O28DjR3uwWZ8ugFu+
         8Qu4rjFpuLbgyXTWRJL0IVNywOvPZTswFij5KYqZxqD91SoLux33RyWaHKR4ee6Afoyq
         dOKrM1/LqB8GfE+xvK4CZ1Qx2//SZSWu8BFHcIprqd8TlziYBCsomSOHHt1nfEOgwVVd
         TIkw==
X-Gm-Message-State: APjAAAVlsm9/XTV0HEZG69BLh1BalSdlW5oAzYSjH/Y9dUOm5aKcM5c3
        dc5X9mYZOuRAfUR0VMqJSjg8e6alLRbEXtEr/mE=
X-Google-Smtp-Source: APXvYqxiLgQc8yPSTvJJx1FN+yxZtvmHJa7Lew80a6w0JtLdvF5G6zzrVnklvhIoaraZOUirmH8zn+vON1NcelEoDBs=
X-Received: by 2002:a2e:301a:: with SMTP id w26mr67530395ljw.76.1564684694917;
 Thu, 01 Aug 2019 11:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190801181411.96429-1-joel@joelfernandes.org>
In-Reply-To: <20190801181411.96429-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 1 Aug 2019 14:38:03 -0400
Message-ID: <CAEXW_YRHtQB+9aVSK3Db1x_417=JvOnwtctte_r8WTS8+20EAw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Apply new rest conversion patches to /dev branch
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 1, 2019 at 2:14 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> This series fixes the rcu/dev branch so it can apply the new ReST conversion patches.

Weirdly enough, Patch 4/9 did not get received by the archive, but
patchwork did pick it up:
https://lore.kernel.org/patchwork/patch/1109574/
