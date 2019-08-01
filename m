Return-Path: <SRS0=/vWc=V5=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6842AC19759
	for <rcu@archiver.kernel.org>; Thu,  1 Aug 2019 20:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E14F206B8
	for <rcu@archiver.kernel.org>; Thu,  1 Aug 2019 20:04:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lxeb6aed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388859AbfHAUEb (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 1 Aug 2019 16:04:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45780 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388766AbfHAUE2 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 1 Aug 2019 16:04:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id u10so12439812lfm.12
        for <rcu@vger.kernel.org>; Thu, 01 Aug 2019 13:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G8kSafWLVCKIynBiOq3kftW6ud+zrU/Ah+bFDI9XyRw=;
        b=lxeb6aedLfL0QNVbLio6Rq2M7BN0MFRHlDRJsfc17kkNEgsuJKRk3nVxI8BcXGwtS2
         RBg+diMAvn31GiFoCO952Op1PAxJgBcBLze2mzdgOlqgtJ23XCls4jK+ou43QzPNd4K/
         kkl1wacjh8wfiEb8AEzHoH07rMubTPG847lpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8kSafWLVCKIynBiOq3kftW6ud+zrU/Ah+bFDI9XyRw=;
        b=hSzHpG1YxqWdD5pXtUdqDso+KjrN8rFF78YCrLMW6YtfMmPNSV29pRFLRft9KIv4R7
         fx/IRgi7mrZmzhk19g0JGdt1Oe4t7KQ/SUODYu5lic/HXGTQpj4StTBKYifdj9y7RAxy
         WNtmeP2AGDski4z/2Sn89gl5GlwpuuoH6t64SHGUZrSIFXMv1B0mbWyJmmGdDw444ImO
         cEUg7M/cN8dFP1KOQdfzAaEWKRVJwnz0dgsDT6Q4ifIfcIn/COIgQ0qyrJT1ybHihpLf
         QTv9+tYwZfid8boeXcaOArwLiVMSUleV/ztmf5xXJdf+5PQbbG/Tw5Ml27moqerPXI4l
         6KFA==
X-Gm-Message-State: APjAAAUyMNyiiwQZstNN90ruZfY1bgecmrqOrQbRmLRLfSL1tt+i9lv0
        72nnIIgXZCR7AmTU2L9y9U9jRaSxJDGj6b+G/gE=
X-Google-Smtp-Source: APXvYqwBImzbg+Nph0vje0uPb5oNfvjiwYe7SVdjs1n5uadpbW2oUzKRrgwcvKlryi/d4M8MxfTMwRjVA54YK2GaJa4=
X-Received: by 2002:a19:ccc6:: with SMTP id c189mr61580827lfg.160.1564689866209;
 Thu, 01 Aug 2019 13:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190801181411.96429-1-joel@joelfernandes.org> <20190801195832.GP5913@linux.ibm.com>
In-Reply-To: <20190801195832.GP5913@linux.ibm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 1 Aug 2019 16:04:15 -0400
Message-ID: <CAEXW_YQ-JnuZGj7zUtmvY0Cn4swoHXoR6UD=iPKw56N55CL3-Q@mail.gmail.com>
Subject: Re: [PATCH 0/9] Apply new rest conversion patches to /dev branch
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Aug 1, 2019 at 3:58 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>
> On Thu, Aug 01, 2019 at 02:14:02PM -0400, Joel Fernandes (Google) wrote:
> > This series fixes the rcu/dev branch so it can apply the new ReST conversion patches.
> >
> > Patches based on "00ec8f46465e  rcu/nohz: Make multi_cpu_stop() enable tick on
> > all online CPUs"
> >
> > The easiest was to do this is to revert the patches that conflict and then
> > applying the doc patches, and then applying them again. But in the
> > re-application, we convert the documentation
> >
> > No manual fix ups were done in this process, other than to documentation.
>
> Ah, I was expecting that you would forward-port the conversion, but
> yes, that could be painful and error prone.
>
> But given that there are some dependencies on these patches, could you
> please use the following alternative procedure for the patches that
> touch both code and documentation?
>
> o       Revert only the documentation portion of each commit.  I will
>         then merge the partial reverts with the original commits.
>
> o       Apply the documentation conversion.
>
> o       Reapply the documentation portions on top of the conversion.

Sure, this would be better. I will do this in the evening and send it
to you. Thanks,

 - Joel
