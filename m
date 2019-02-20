Return-Path: <SRS0=hk7p=Q3=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E28C43381
	for <rcu@archiver.kernel.org>; Wed, 20 Feb 2019 04:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4ECE2147A
	for <rcu@archiver.kernel.org>; Wed, 20 Feb 2019 04:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fuaOegiy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfBTELt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 19 Feb 2019 23:11:49 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36762 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfBTELt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 19 Feb 2019 23:11:49 -0500
Received: by mail-lf1-f65.google.com with SMTP id q11so16489800lfd.3
        for <rcu@vger.kernel.org>; Tue, 19 Feb 2019 20:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=db6rNe8FXqzsar+Of4OlqOzZTp/jEx1xhLf6TcXLfvQ=;
        b=fuaOegiyQG/ppLU7U/HkS3Fqp5fmTeS/dQnPC6emwcCsg8QeE2i6xA+9D2Z0Ja81uI
         PmIxUNBF/qKQ9kUP28Fs3UWerXDtY93/1MH023gPd3R1MCYnFYziNw4O2hWxe8hC7ZkT
         hZ0GaVgDa8TWJTwZVCq4w9YA2kjPRunZJm2jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=db6rNe8FXqzsar+Of4OlqOzZTp/jEx1xhLf6TcXLfvQ=;
        b=Gn2+R0WQboorLcbPMctmQmezFa7irvx2e11ls+syNuZNLsTqd3T5rfpDW7A5PRE4jV
         4FI/3QTuJgfXhVqEqAHT6g6LRUZtpzRK7MbDXT+F8uD5TRW+l7aUxixujNnbp34kjegG
         H1xIukPgP/b/+6qoL24DFi4GdqZd8o4/Gemh5ar4tTOFGFrifkLPDaT/9BynZkim5qeh
         rMiWi4R6D8bqOtiWbbiL6pbK38SrxA661ur1801+lHMobMkTFkTORyc4TAPORf9PLkfT
         QHEAmlmLs5srXaQqHXxZwNzUbIJPdDzYEtM1LExq/KOv1oJv5xznb2Wl4CzFinJnutOR
         GSCw==
X-Gm-Message-State: AHQUAuYKZyJRSCtyU7G872QuPw52zquR1xIvxD6VdqbJz8aI/CHiK6dg
        hbtOhili/R4mt6qkYxfOXDXzV/0/D0W8KB5kpwniHw==
X-Google-Smtp-Source: AHgI3IZgLGOicKs820B9PCtpmESxrwPnr+mJbTFZsy9LKzbID33x7DWDeZ35zwucBMjh1mzCivqwtxYr4iyMqRyfKww=
X-Received: by 2002:a19:d250:: with SMTP id j77mr18855692lfg.21.1550635907264;
 Tue, 19 Feb 2019 20:11:47 -0800 (PST)
MIME-Version: 1.0
References: <20190220040827.136184-1-joel@joelfernandes.org>
In-Reply-To: <20190220040827.136184-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 19 Feb 2019 20:11:36 -0800
Message-ID: <CAEXW_YRasK=os37QxCwoAY+DXKVD3bBTvR4qH3jaSJB3rP5a-Q@mail.gmail.com>
Subject: Re: [RFC 0/5] RCU fixes for rcu_assign_pointer usage
To:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Feb 19, 2019 at 8:08 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> These patches fix various RCU API usage issues found due to sparse errors as a
> result of the recent check to add rcu_check_sparse() to rcu_assign_pointer().
>
> This is very early RFC stage, and is only build tested. I am also only sending
> to the RCU group for initial review before sending to LKML. Thanks for any feedback!
>
> There are still more usages that cause errors such as rbtree which I am
> looking into.
>

Looks like it got sent to LKML anyway, ;-) That's Ok since it is
prefixed as RFC.
