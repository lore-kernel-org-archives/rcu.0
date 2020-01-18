Return-Path: <SRS0=UQpt=3H=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98637C33C9E
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 02:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D46724673
	for <rcu@archiver.kernel.org>; Sat, 18 Jan 2020 02:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NmhpOfXH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgARCeg (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 17 Jan 2020 21:34:36 -0500
Received: from mail-pj1-f53.google.com ([209.85.216.53]:36511 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgARCeg (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 17 Jan 2020 21:34:36 -0500
Received: by mail-pj1-f53.google.com with SMTP id n59so4183934pjb.1
        for <rcu@vger.kernel.org>; Fri, 17 Jan 2020 18:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UpUDWKuFM/kCm4AcD4Eed4r776MUrRTeA5ImShZibWU=;
        b=NmhpOfXHmRSx+piZyBISrFGWiMtP9aJkjLtxDZH+fL//foxAl2XQBe3q7RZRV+fGJs
         tuXvY7jkdTKV9O/yjTJdv1XdQSlOOkPGbxktdFwYLlWMk9G3YCXTOGphqbjR8QFcBVYA
         drYO9As2yhZzfIY31oLBj7RsswmTO7O1w1jcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UpUDWKuFM/kCm4AcD4Eed4r776MUrRTeA5ImShZibWU=;
        b=mQQRhwip+3NZYBt7l2gQxPwcj/jeIX/hvKSXhRIqszZOCuIaWilwrynRn7WWBq0QZS
         rSitZHpHnOjub+xrpXoAj/FV7LH5nwZIex3PBzTdj3qzZa05uUHEszU30/+s09sdiNk7
         Hjh64Xi97g3j4ifx70hqs53pAMVblI/i5azaH1/qyt3Pq+aeRrTO3hub5DnH9DnkjoW1
         Pdd/3px2M7kiaZtaWOua0NmJXbjWRLjduBB+sHhOi/h/QP6Rgr2FIx5oCm0KJ1uuQ9Sw
         SXpz9kFl/vUSzXQqIq0KtbDdRP4vdse0EqFeon90kpmuQjdWGr5sKbSgny/vbr3ALn7F
         Gt1Q==
X-Gm-Message-State: APjAAAVrBAveVmC7QQFVapy1BgiRTQRWb3Ngrjt2koNcdObxlQpLA/2+
        qyShEVWSlXKRp9TQnZ5y1l1rZw==
X-Google-Smtp-Source: APXvYqyWBLlk0ZIfrAc3HhhNm0ZSlGLY/A7K/l0Tm0zFPX6hc3hKeSpZemyIneEgZGnLR1Z2e6jYQQ==
X-Received: by 2002:a17:90a:d3d7:: with SMTP id d23mr9114258pjw.53.1579314875460;
        Fri, 17 Jan 2020 18:34:35 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id fa21sm8820424pjb.17.2020.01.17.18.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 18:34:35 -0800 (PST)
Date:   Fri, 17 Jan 2020 21:34:34 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, rostedt@goodmis.org, bristot@redhat.com
Subject: Re: RCU_BOOST not working for me
Message-ID: <20200118023434.GB244899@google.com>
References: <20200117215814.GB206250@google.com>
 <20200117221804.GA211665@google.com>
 <20200117231756.GO2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117231756.GO2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Jan 17, 2020 at 03:17:56PM -0800, Paul E. McKenney wrote:
[...] 
> But rcutorture already has tests for RCU priority boosting.  Or are those
> failing in some way?

Yes there are tests, but I thought of just a simple experiment to study this.
Purely since it is existing RCU kernel code that I'd like to understand. And
me/Daniel are also looking into possibly using run-time / trace-based
verification some of these behaviors.

thanks,

 - Joel

