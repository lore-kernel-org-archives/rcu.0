Return-Path: <SRS0=e+uF=U6=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE0BC0650E
	for <rcu@archiver.kernel.org>; Mon,  1 Jul 2019 13:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38E221721
	for <rcu@archiver.kernel.org>; Mon,  1 Jul 2019 13:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="XWregEDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfGANxt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 1 Jul 2019 09:53:49 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42874 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfGANxt (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 1 Jul 2019 09:53:49 -0400
Received: by mail-pg1-f193.google.com with SMTP id t132so2731526pgb.9
        for <rcu@vger.kernel.org>; Mon, 01 Jul 2019 06:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CnqcdAZEqlhe5AvSTX+V5wDK1OqDo6RCXWT/qry/0jg=;
        b=XWregEDl1FFMPhgi4vXgSGCiek/WrfkHRgLPn5FgA3IxY5gqLSnf+5oM7t9Shhq0tn
         k9ig4d4b372SkcPvNZ2VUnZfZjIBURPZFmBU8+pS1u5GZpAe/nX6VsDTDksvNUpBbxkc
         ttX2Jr0lLx1e8hSiszEog64NrgL4txrFPVS4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CnqcdAZEqlhe5AvSTX+V5wDK1OqDo6RCXWT/qry/0jg=;
        b=YXbhi1JPJEab/gK7Rlb+cUiUhFEiDTc2czdaEwv8eR7uB0ScwKdUiuDosXelgiPOoi
         aZTG9qju32EkQ9OGqDEr40QVnJeSbgT+lWtw7SBUj6+S6kR+BF0i/CETcPayHdvFjo2X
         TeIHqI1+r/YL4sfwIliNhUsPo4UqQTiEiO0yRZXfN6O5WnLImbHC3y9YAGcBS7tjdQlQ
         3TawyieHU4BwvmtCuRlIgiJoW0TO1ErrUlgrpmB6mL0SU37zGZOvKZ5m28wEVPfqJwQV
         OL9GeYa0TyA1ozGV6nCE/RvcLXoD1goEGdC8/ROn/RBm52FGi/ZGfuJC+dOdIOYKAdRV
         x8Iw==
X-Gm-Message-State: APjAAAXqoRD5wbd8noQwwnkpY/E9/D50J3VNd/as50yXYDx+lC3d0WM1
        P1r5WIX/qUkjXRXY5GWKnm3I3A==
X-Google-Smtp-Source: APXvYqxX5xXZI0X2mxnuICMgqyXLY+28omTo2AX9jZBNCHB9Nez+eCLHSmiTzqOVBM+4vcQjsnymdA==
X-Received: by 2002:a63:7e1d:: with SMTP id z29mr11833928pgc.346.1561989228598;
        Mon, 01 Jul 2019 06:53:48 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z13sm11274343pjn.32.2019.07.01.06.53.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 06:53:47 -0700 (PDT)
Date:   Mon, 1 Jul 2019 09:53:46 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>, rcu@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC 1/3] rcu: Expedite the rcu quiescent state reporting if
 help needed
Message-ID: <20190701135346.GA167294@google.com>
References: <20190701040415.219001-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701040415.219001-1-joel@joelfernandes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Jul 01, 2019 at 12:04:13AM -0400, Joel Fernandes (Google) wrote:
> The t->rcu_read_unlock_special union's need_qs bit can be set by the
> scheduler tick (in rcu_flavor_sched_clock_irq) to indicate that help is
> needed from the rcu_read_unlock path. When this help arrives however, we
> can do better to speed up the quiescent state reporting which if
> rcu_read_unlock_special::need_qs is set might be quite urgent. Make use
> of this information in deciding when to do heavy-weight softirq raising
> where possible.

Just fyi, TREE01-06, SRCU-N and SRCU-t passed overnight testing with this series.

