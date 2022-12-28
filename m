Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB79BC10F1B
	for <rcu@archiver.kernel.org>; Wed, 28 Dec 2022 02:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiL1CJ1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 27 Dec 2022 21:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiL1CJY (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 27 Dec 2022 21:09:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381A9DFC2;
        Tue, 27 Dec 2022 18:09:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B83F4611F2;
        Wed, 28 Dec 2022 02:09:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F904C433D2;
        Wed, 28 Dec 2022 02:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672193361;
        bh=0+9mbLzHdVINwOD8vgA/LPr1HjdwcqowwuSzxvl7dXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aeWc+l1u/GpeRN6IHZfdLNkL8f8QnVLmPhoDo3v7jJ5UYL/GYcKP7FF3ARl0YfVRp
         w3873WEAGUoq7z/E5YbwvCHXk75rJ+c44eesw3h6fylZTk1UEBb3Py3e2raHxojxQm
         bkNqVLJ6n7lKQMRuXR77bf7Xm/gJr5hyYA0KViggYysry68z67sUte+xPFApUAeX5w
         aOPcDHXvCq3Rdgklwu88jKx988Gn5cUdQdNxoc7mwt/4ndbeslOR+5bY8C52qt7JFT
         C9pUKBfrC1T8ncUFsUj2F3dDXgYAiSQOMlD5ghOxS2ooCetb4GWnZsLoHLsXEmR20j
         UUHQYNhlt+MjA==
From:   SeongJae Park <sj@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org,
        alexander.h.duyck@linux.intel.com, paulmck@kernel.org,
        linux-mm@kvack.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_reporting: replace rcu_access_pointer() with rcu_dereference_protected()
Date:   Wed, 28 Dec 2022 02:09:18 +0000
Message-Id: <20221228020919.1511138-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <4bc4ab74-3ccd-f892-b387-d48451463d3c@huawei.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 28 Dec 2022 09:45:00 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2022/12/28 9:29, SeongJae Park wrote:
> > Page reporting fetches pr_dev_info using rcu_access_pointer(), which is
> > for safely fetching a pointer that will not be dereferenced but could
> > concurrently updated.  The code indeed does not dereference pr_dev_info
> > after fetcing it using rcu_access_pointer(), but it fetches the pointer
> 
> Thanks for your work. Might something to improve.
> 
> s/fetcing/fetching/
> 
> > while concurrent updtes to the pointer is avoided by holding the update
> 
> s/updtes/updates/

Thank you!  I shall add these to scripts/spelling.txt.

> 
> > side lock, page_reporting_mutex.
> > 
> > In the case, rcu_dereference_protected() is recommended because it
> > provides better readability and performance on some cases, as
> > rcu_dereference_protected() avoids use of READ_ONCE().  Replace the
> > rcu_access_pointer() calls with rcu_dereference_protected().
> > 
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> > Changes from v1
> > (https://lore.kernel.org/linux-mm/20221227192158.2553-1-sj@kernel.org/)
> > - Explicitly set the protection condition (Matthew Wilcox)
> > 
> >  mm/page_reporting.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> > index 79a8554f024c..5c557a3e1423 100644
> > --- a/mm/page_reporting.c
> > +++ b/mm/page_reporting.c
> > @@ -356,7 +356,8 @@ int page_reporting_register(struct page_reporting_dev_info *prdev)
> >  	mutex_lock(&page_reporting_mutex);
> >  
> >  	/* nothing to do if already in use */
> > -	if (rcu_access_pointer(pr_dev_info)) {
> > +	if (rcu_dereference_protected(pr_dev_info,
> > +				lockdep_is_held(&page_reporting_order))) {
> 
> I think it should be lockdep_is_held(&page_reporting_mutex) instead of
> lockdep_is_held(&page_reporting_order) here?

You're right, thank you for finding this.

I will fix these in the next version.


Thanks,
SJ

> 
> Thanks,
> Miaohe Lin
