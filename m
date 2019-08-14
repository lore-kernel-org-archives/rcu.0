Return-Path: <SRS0=j199=WK=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FF9C32753
	for <rcu@archiver.kernel.org>; Wed, 14 Aug 2019 22:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC4C21721
	for <rcu@archiver.kernel.org>; Wed, 14 Aug 2019 22:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PzkYxpR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfHNWmI (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 14 Aug 2019 18:42:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43242 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbfHNWmI (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 14 Aug 2019 18:42:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so249757pld.10
        for <rcu@vger.kernel.org>; Wed, 14 Aug 2019 15:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hMEHK3D0DeqRXHR3V666QBC5hkX1AwG9+yo5maZ51Ws=;
        b=PzkYxpR+WsvJ0GKSPP9wt0l4YqVfxxZlRPySwxDENc0uquYDE4FH3bIiRoxfTPA1v0
         daLJqf8B4sQuDac5d61sdyojfc8b9g9yhK52TGU9vCCC2Q6Ozm2F1P/8FaMyzsrTVEb0
         3Xm3jaPn/9nJxAF4SojpaoPdnkNoRcv5nmLjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hMEHK3D0DeqRXHR3V666QBC5hkX1AwG9+yo5maZ51Ws=;
        b=Tb9u2kcOjcVZ9JD+w1afirriC7lary0RauzUR1g2yrXwkCmTA2U0d50uU4cw2+/9BM
         mlrIS8RDOUxgzgu2B1T2tnfXXOhYqwsesGAgHWx7/8NwYYEnCkrK7JJBwscASmJL5GbX
         sup1wR8fhpUjnPYu/l2RoW9n8cu8JRELH+SlaSsEo3RrChjvA7D5zMByq3L6Y9oHAp6D
         i5860mfYYbSQLAFU3MBiC5ztk635OajJlQbro1N4+HpBpxff9l4ZQ9/S4c1FDaB4ViW0
         xhU7v2uRt57rw70c/OieX/XQXKqQFzLib9gHqYBMQVkj7hwpvruAOcnACIA2lw11SHl4
         b5zg==
X-Gm-Message-State: APjAAAX9B8r+eiMbzgGrBRr42G45E9zDJPodaumK/cpImcHm9J5ic15x
        LwlJDDjQCUM9Qvz7yz7diba+cA==
X-Google-Smtp-Source: APXvYqxeCtn5YQ0RrQb6xdht/iQSMOK2IulsqUWdD2tppaE3yQNeQo12jNVOsbuEuixCZiNvYLOGgg==
X-Received: by 2002:a17:902:2f05:: with SMTP id s5mr1571241plb.170.1565822527290;
        Wed, 14 Aug 2019 15:42:07 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v6sm31357pjn.13.2019.08.14.15.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 15:42:06 -0700 (PDT)
Date:   Wed, 14 Aug 2019 18:42:05 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] workqueue: Convert for_each_wq to use built-in list
 check (v2)
Message-ID: <20190814224205.GC69375@google.com>
References: <20190811221111.99401-1-joel@joelfernandes.org>
 <20190814194841.GA588936@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814194841.GA588936@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, Aug 14, 2019 at 12:48:41PM -0700, Tejun Heo wrote:
> Hello, Joel.
> 
> On Sun, Aug 11, 2019 at 06:11:09PM -0400, Joel Fernandes (Google) wrote:
> > list_for_each_entry_rcu now has support to check for RCU reader sections
> > as well as lock. Just use the support in it, instead of explicitly
> > checking in the caller.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

> >  #define for_each_pwq(pwq, wq)						\
> > -	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node)		\
> > -		if (({ assert_rcu_or_wq_mutex(wq); false; })) { }	\
> > -		else
> > +	list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,		\
> > +				 lock_is_held(&(wq->mutex).dep_map))
> 
> Why not lockdep_is_held() tho?

Yes, that's better.

thanks,

 - Joel

