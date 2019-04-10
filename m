Return-Path: <SRS0=7kaP=SM=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF012C10F14
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 18:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C60F82077C
	for <rcu@archiver.kernel.org>; Wed, 10 Apr 2019 18:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BtGDGEOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbfDJSVm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 10 Apr 2019 14:21:42 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:39966 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730693AbfDJSVi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 10 Apr 2019 14:21:38 -0400
Received: by mail-vk1-f195.google.com with SMTP id l17so784972vke.7
        for <rcu@vger.kernel.org>; Wed, 10 Apr 2019 11:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cja3R3p21UXnsf4jp1j6UW2X7hhQXngQByR/XkQ7/d0=;
        b=BtGDGEOp0xliko79Vrb2m+YkM9JRr3L4IhxNxzoU3ORU6lsSrDEPLtLuVwJ0P5ljUP
         JzRHPdYhQ/dXgCM+3jCzBato2MNeP+wV4z6c8noa3IEbciuzTudHBluOkvDmbpLTgnN/
         CPFAi+gK4567BFfr3DM2bUiahfm2hmo3+4Sfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cja3R3p21UXnsf4jp1j6UW2X7hhQXngQByR/XkQ7/d0=;
        b=TnZymak8cPVvycbehx95nOGrpRXe57Vw6+HcGtcAjwPVNfyTlXfiKFunLicRVp9w/a
         +OSTYuMR2zP7d+iI+vpp51hLFo2aCg4xdnhhTEqJbzTpvz9/i9uG1uVeGLTymhCjFGjC
         LZvSZnYMSRuz9t0dnliUXZU0qi7K8DVHa873UvvWnQBscYidy6kwzJxVVGAGZCRJ5aic
         OvdcJpSMPzN9g//Dz8ITiG4AvNYrNG2C8aZwq5LH4uQNG4sGkgEPmtDhXVUG4j/QKdnv
         rkmMMM0+7nnNTJfvZ1I/FU7ONV/cidc1GDORSt9ssKst8SYXa9rFv5Eb8i47kVZ1DwXb
         7bbg==
X-Gm-Message-State: APjAAAWexS97ECGGSAC790IzO1rt3R8fSK1IEA8vyVUi+fQI22cr6O0h
        MubWNiWfD6gNpgM2LsYOsjWXI7fZTN4=
X-Google-Smtp-Source: APXvYqyWT+w86UAnlHuDEKbVda9j5gqse/RtylvAvVz2ZUTa6tDa52nlTXY78qQIi8h7FILgBQ1weg==
X-Received: by 2002:a1f:ab8d:: with SMTP id u135mr21949619vke.80.1554920496422;
        Wed, 10 Apr 2019 11:21:36 -0700 (PDT)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id j71sm28775126vsd.0.2019.04.10.11.21.35
        for <rcu@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 11:21:35 -0700 (PDT)
Received: by mail-vk1-f181.google.com with SMTP id 195so780114vkx.9
        for <rcu@vger.kernel.org>; Wed, 10 Apr 2019 11:21:35 -0700 (PDT)
X-Received: by 2002:a1f:29c5:: with SMTP id p188mr25025647vkp.24.1554920494773;
 Wed, 10 Apr 2019 11:21:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190410011418.76408-1-joel@joelfernandes.org>
 <CAGXu5jKs6Ag2L+GYEVYAzPky1pLntZt-Tc5ki-pqjVoyCWgxxg@mail.gmail.com> <20190410174800.GA259061@google.com>
In-Reply-To: <20190410174800.GA259061@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 10 Apr 2019 11:21:23 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKEek9H0uWyB346mE3MBhhNVGo7qyy=y0qAZFauxQ3iEw@mail.gmail.com>
Message-ID: <CAGXu5jKEek9H0uWyB346mE3MBhhNVGo7qyy=y0qAZFauxQ3iEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] module: Prepare for addition of new ro_after_init sections
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Android Kernel Team <kernel-team@android.com>,
        Jessica Yu <jeyu@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Apr 10, 2019 at 10:48 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> Thanks, if you are Ok with it, I will add your Reviewed-by tag as well.

With those fixes, absolutely. :) Thanks!

-- 
Kees Cook
