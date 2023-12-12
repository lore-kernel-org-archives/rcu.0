Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hey09nK7"
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCBA184;
	Tue, 12 Dec 2023 09:23:50 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cecb004339so3175724b3a.3;
        Tue, 12 Dec 2023 09:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702401829; x=1703006629; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=77k5xhH3hhXQbw86kfVyq2j870GiGq/zqEUCE85wFZA=;
        b=Hey09nK71rjPAR/TzkKTgOp8Vg3HpJQEcFeTCGtthCw+J7jE+9CEY7keWD543vZ/Kv
         rUfyZG6lhT5BRVQlzr1OeY5hJWXR0azfh19h6CfsbD+ucGw0uLL5cjEsgQHGkivLriPC
         E3bjc08eq6ua8V90AoCwTrdTbY6GZV35Vg65COkjHfCSBl8Xkq1NZRWcu+dDoAh2KVMZ
         e+hF0e9JpkmXfEtzP88OadzHeBKnXKg8OtP8j9fW8B/tnSM/7/bpmt77wFXYcOs5O8Jc
         qAD3sJpIiaqRmrJhSfh/mx9BcKoHKrPeVQbrfZKja4MRzhi9A5pUq/1fhxOppLo9J6Od
         HoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702401829; x=1703006629;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77k5xhH3hhXQbw86kfVyq2j870GiGq/zqEUCE85wFZA=;
        b=HtyNL1rS0ixe13sEp7D78tPwNk0eWIea8yu0aWzz1bQMSjYvolBGk1bi0tgr2uWQbP
         YJm+9yN+PmBQNEprTZT+oILdkZS8porPgGiyBBx9vSRvZmCzBjwxfgajSAy/geFpzrFr
         oZosVGfQzHJpDkulwfE8BnWOzpBtRCq53AThFpivRwYKBUKT0m/Inv72aAFeJgyGnJif
         tAvqQxYf+QNpwAbi9ksNNYDz3y60qkwYWT5hcSzKw8TQL9N93mdH0S5GtkxJkqguxaCR
         aea1euotQTDCtLJUPHe0MLVNjcGdq1eVPC+Y6nZr4K5+ybzAyQ77bDLzjYiSV1I9lIUR
         zMtw==
X-Gm-Message-State: AOJu0YwzwTuARIcriDfMlgMQ0GXqONIxQHlG/5KnvxN70VZ+RkqcGVO8
	fGXX2vFyc6HAVGzy4YruZ/ybWJLjfTnZ94ri
X-Google-Smtp-Source: AGHT+IGSkLkafckUlzV4IGdiSCFzPPwmbn7F7TFVmbfUubljLV0bKQTgdcXh11lhRlrY/ahDJvbPqA==
X-Received: by 2002:a05:6a20:914b:b0:18b:aceb:7a79 with SMTP id x11-20020a056a20914b00b0018baceb7a79mr3647717pzc.12.1702401828327;
        Tue, 12 Dec 2023 09:23:48 -0800 (PST)
Received: from neeraj.linux ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id b16-20020aa78710000000b006cea1db00cbsm8246636pfo.204.2023.12.12.09.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:23:47 -0800 (PST)
Date: Tue, 12 Dec 2023 22:53:43 +0530
From: "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
	paulmck@kernel.org, Neeraj.Upadhyay@amd.com
Subject: [PATCH rcu 0/5] Documentation updates for v6.8
Message-ID: <20231212172343.GA11383@neeraj.linux>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

This series contains documentation updates:

1.      Documentation: RCU: Remove repeated word in comments, courtesy
        of Charles Han.

2.      rculist.h: docs: Fix wrong function summary, courtesy of Philipp
        Stanner.

3.      Clarify RCU Tasks reader/updater checklist.

4.      Mention address and data dependencies in rcu_dereference.rst.

5.      Clarify historical disclaimers in memory-barriers.txt.


Thanks
Neeraj

------------------------------------------------------------------------

 Documentation/RCU/checklist.rst       |   25 ++++++++++++++++---------
 Documentation/RCU/rcu_dereference.rst |   27 ++++++++++++++++++++-------
 Documentation/RCU/torture.rst         |    2 +-
 Documentation/memory-barriers.txt     |   17 ++++++++++-------
 include/linux/rculist.h               |    2 +-
 5 files changed, 48 insertions(+), 25 deletions(-)
