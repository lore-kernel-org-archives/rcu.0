Return-Path: <SRS0=Como=TE=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B204C43219
	for <rcu@archiver.kernel.org>; Sat,  4 May 2019 18:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D2A205ED
	for <rcu@archiver.kernel.org>; Sat,  4 May 2019 18:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="f6QP1gZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfEDS7s (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 4 May 2019 14:59:48 -0400
Received: from mail-pf1-f178.google.com ([209.85.210.178]:34273 "EHLO
        mail-pf1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbfEDS7s (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 4 May 2019 14:59:48 -0400
Received: by mail-pf1-f178.google.com with SMTP id b3so4594362pfd.1
        for <rcu@vger.kernel.org>; Sat, 04 May 2019 11:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3f3BmSGu4D5Re9H6+1cm9Ff/AiFAYiqYBhLA8a8MNak=;
        b=f6QP1gZBIJ4C+Y1huHHNKJBUAU0mC3eYumpCPgRQjADOqPqF+3KAaWZjPVvzealo9Z
         6hnW3EVY3dvyKma45Y0kHlDUi/d6tG+NO8max0PHz0Px50Rdvm6dPDu3LJ9yD1R1jBZg
         AsgvS1I6hnQbBlduXjGVi8pN+4Wls24wWoWpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3f3BmSGu4D5Re9H6+1cm9Ff/AiFAYiqYBhLA8a8MNak=;
        b=qbgAJffR4x3D455nsQXLBoUWYUg61AHV33rdGHBDVPmpxkxHSOZvqO/YByRxLdoBU7
         PVnzZgPYQyMA1oE1CxcXiGl7/dOnc3ICZhBBqTMN7nd6FFC8YJVvQHusqKP7A8478l+c
         eFppWpeFUqg4JNiYd5/OMWNl54rbPF5sqsPh85LD54/3yxHv9ia8+PZPPg66ciG2Nuas
         CTb1GSvIYIpMkC23fQtHBl49sIQSpOToRdRix0xXM8aAy65w4tuqLFwtvHB5eq1ltKl+
         kszuCLWBczlIoriAaT8Iy/SFGihERYSw+ze4FjKm8jexhlelmPMaY8ML43oiAB4tNIfN
         39Cg==
X-Gm-Message-State: APjAAAVzkZjuhNGc1kD8PSCQ2UhiEIIjdsjY8g3JK2Tcx3gNI8JmDKCE
        BINL//Kw8iKhQsHf/OxF+wSMZQ+wTNc=
X-Google-Smtp-Source: APXvYqx2NCgYok/Doiy5ZmUH0ZUqWL4O+dYY2C3yQEmMs6Ua/dUqkTHw4pmg61JpRBRGafLKp/44fw==
X-Received: by 2002:a63:2b4c:: with SMTP id r73mr21079162pgr.181.1556996387167;
        Sat, 04 May 2019 11:59:47 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f20sm10787417pff.176.2019.05.04.11.59.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 May 2019 11:59:46 -0700 (PDT)
Date:   Sat, 4 May 2019 14:59:44 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     rcu@vger.kernel.org, paulmck@linux.ibm.com
Subject: Should list_entry_rcu use rcu_dereference ?
Message-ID: <20190504185944.GA79652@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,
Sorry if this is a silly question.

Looking at the list_entry_rcu primitive, I see it does direct READ_ONCE
on ptr. That's Ok, but rcu_dereference also does additional lockdep and
sparse checking.  Why not call rcu_dereference instead of READ_ONCE? The
pointer may be dereference by the caller so IMO makes sense to check.

Here is the definition of list_entry_rcu:
/**
 * list_entry_rcu - get the struct for this entry
 [snip]
* This primitive may safely run concurrently with the _rcu list-mutation
 * primitives such as list_add_rcu() as long as it's guarded by rcu_read_lock().
 */
#define list_entry_rcu(ptr, type, member) \
	container_of(READ_ONCE(ptr), type, member)

Also, I was curious why hlist_for_each_entry_rcu() uses rcu_dereference_raw()
while __hlist_for_each_rcu)_ uses rcu_dereference(). I feel both should use
rcu_dereference to have the lockdep checking. Is this not done due to
performance reasons?

thanks!

  - Joel

https://cdn-images-1.medium.com/max/1600/0*XTYvSNj_rT2UZwfm.png
