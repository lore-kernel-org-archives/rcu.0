Return-Path: <SRS0=upIL=VI=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3E8C742A1
	for <rcu@archiver.kernel.org>; Thu, 11 Jul 2019 20:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EE7208E4
	for <rcu@archiver.kernel.org>; Thu, 11 Jul 2019 20:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="OH1nH1Jx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfGKUuk (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:50:40 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35336 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbfGKUuk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 11 Jul 2019 16:50:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id x25so7201361ljh.2
        for <rcu@vger.kernel.org>; Thu, 11 Jul 2019 13:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dYjxp66wgB3t394QorK0WPrW2jXGX2qG/znE9bxRn1o=;
        b=OH1nH1JxcyIJ1Frv7bR1psVD2AkOX68Z06jMu6w+iKf4koMKEnVt0JThRnXKzImvV7
         J3Z3Nl/H5FA/erTmCGF/qw3sMCLW0JXQR/CgOLxF+xN3iTuTAPf+3vmVJxb5wDaonHmn
         N5opQfDUhQroiwNBX3un98PdvECR62kpygl3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dYjxp66wgB3t394QorK0WPrW2jXGX2qG/znE9bxRn1o=;
        b=jmQIZ2zlaBpfURnOLohszQnXH6HAXk6z4pizEF83021twkH7FaX2dERhR+q7jeQoE6
         Yd9wzBRO+Zho6fM1Z0UiPeRjmxrLZLEx2+cq7NYcJ+COM7sVjucPBfI3lhRb7RdOk7bY
         1NC6PchSMIxUVs1ftM5a569a41onn4VWfUEX/wD8t9kjMMPfP0Q/5HQQnWHJYdDYrI+I
         EoGSJNghVrB3Mxmo/dYhnwU19zOmzbB80Z+RnOkF7m42UNkIQtgUT89ZN1Ee3nyOfU8r
         PqXY6/TNycr1+cJ5aQZql+b6MLCECs24AIUAklPNygbC6tM5/ztI4fUZvZLSQTDl2IEZ
         jJlA==
X-Gm-Message-State: APjAAAXZiDN4pcs7ZknW8r4W4lt6mOOXOCqSdOGqoFvppCAQMZlE/+gO
        MLe7NGIWk+3YL44yBguTOS95dm0REeKkGLzTjGg=
X-Google-Smtp-Source: APXvYqyTowl8LDpO3glgWe4q53UddCDACSqIkn83mbNwYk66wIQHKoZZ8RculjXa8Wt7mSwwCQxgYNfcJFE9RnOFrVI=
X-Received: by 2002:a2e:9147:: with SMTP id q7mr3641900ljg.19.1562878238030;
 Thu, 11 Jul 2019 13:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190711204541.28940-1-joel@joelfernandes.org>
In-Reply-To: <20190711204541.28940-1-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 11 Jul 2019 16:50:26 -0400
Message-ID: <CAEXW_YS=Sb6k4_Z-fXdtERTHZDO_PHQCOhx6bhotWduCB7K28w@mail.gmail.com>
Subject: Re: [PATCH] treewide: Rename rcu_dereference_raw_notrace to _check
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>, kvm-ppc@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Jul 11, 2019 at 4:45 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> The rcu_dereference_raw_notrace() API name is confusing.
> It is equivalent to rcu_dereference_raw() except that it also does
> sparse pointer checking.
>
> There are only a few users of rcu_dereference_raw_notrace(). This
> patches renames all of them to be rcu_dereference_raw_check with the
> "check" indicating sparse checking.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

There also these _notrace things but I am Ok with leaving them alone for now:
hash_for_each_possible_rcu_notrace
hlist_for_each_entry_rcu_notrace

- Joel
